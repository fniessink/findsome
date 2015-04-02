Projects = new Mongo.Collection('projects');

Projects.allow({
  update: function(userId, project) { return ownsDocument(userId, project); },
  remove: function(userId, project) { return ownsDocument(userId, project); },
});

Projects.deny({
  update: function(userId, project, fieldNames) {
    // may only edit the following two fields:
    return (_.without(fieldNames, 'title', 'description').length > 0);
  }
});

Projects.deny({
  update: function(userId, project, fieldNames, modifier) {
    var errors = validateProject(modifier.$set);
    return errors.title || errors.description;
  }
});

validateProject = function (project) {
  var errors = {};

  if (!project.title)
    errors.title = "Please give the project a title";

  if (!project.description)
    errors.description =  "Please give the project a brief description";

  return errors;
}

Meteor.methods({
  projectInsert: function(projectAttributes) {
    check(Meteor.userId(), String);
    check(projectAttributes, {
      title: String,
      description: String
    });

    var errors = validateProject(projectAttributes);
    if (errors.title || errors.description)
      throw new Meteor.Error('invalid-project', "You must set a title and description for your project");
      
    var projectWithSameTitle = Projects.findOne({title: projectAttributes.title});
    if (projectWithSameTitle) {
      return {
        projectExists: true,
        _id: projectWithSameTitle._id
      }
    }
    var user = Meteor.user();
    var project = _.extend(projectAttributes, {
      userId: user._id, 
      author: user.username, 
      submitted: new Date(),
      findingsCount: 0,
      sourcesCount: 0
    });
    var projectId = Projects.insert(project);
    return {
      _id: projectId
    };
  }
});