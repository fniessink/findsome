title_error =
  title: jasmine.any(String)


describe 'An item', ->

  it 'is valid when it has a title', ->
    expect(validateItem({title: 'Title'})).toEqual {}

  it 'is valid when it has a title and a description', ->
    expect(validateItem({title: 'Title', 'description': 'Description'}))

  it 'is invalid when it has no title', ->
    expect(validateItem({title: ''})).toEqual title_error

  it 'is invalid when the title is not a string', ->
    expect(validateItem, {title: 10}).toThrowError Match.Error

  it 'is invalid when the description is not a string', ->
    expect(validateItem, {title: 'Title', 'description': 10}).toThrowError Match.Error


describe 'A project', ->

  beforeEach ->
    this.project =
      title: 'Title'
      members: ['Dummy user']
      checklists: []

  it 'is valid when it has a title and at least one project member', ->
    expect(validateProject(this.project)).toEqual {}

  it 'is invalid when it has no title', ->
    this.project.title = ''
    expect(validateProject(this.project)).toEqual title_error

  it 'is invalid when it has no members', ->
    this.project.members = []
    expect(validateProject(this.project)).toEqual
      members: jasmine.any(String)

  it 'is invalid when it has no title and no members', ->
    this.project.title = ''
    this.project.members = []
    expect(validateProject(this.project)).toEqual
      title: jasmine.any(String)
      members: jasmine.any(String)

  it 'is invalid when the members is not an array of strings', ->
    this.project.members = [10]
    expect(validateItem, this.project).toThrowError Match.Error

  it 'is invalid when the checklists is not an array of strings', ->
    this.project.checklists = [10]
    expect(validateItem, this.project).toThrowError Match.Error


describe 'A source', ->

  it 'is valid when it has a title', ->
    expect(validateSource({title: 'Title'})).toEqual {}

  it 'is invalid when it has no title', ->
    expect(validateSource({title: ''})).toEqual title_error


describe 'A finding', ->

  beforeEach ->
    this.finding =
      title: 'Title'
      sources: ['Dummy source']

  it 'is valid when it has a title and at least one source', ->
    expect(validateFinding(this.finding)).toEqual {}

  it 'is invalid when it has no title', ->
    this.finding.title = ''
    expect(validateFinding(this.finding)).toEqual title_error

  it 'is invalid when it has no sources', ->
    this.finding.sources = []
    expect(validateFinding(this.finding)).toEqual
      sources: jasmine.any(String)

  it 'is invalid when it has no title and no sources', ->
    expect(validateFinding({title: '', sources: []})).toEqual
      title: jasmine.any(String)
      sources: jasmine.any(String)

  it 'is invalid when the members are not an array of strings', ->
    expect(validateFinding, {title: 'Title', sources: [10]}).toThrowError Match.Error


describe 'A risk', ->

  beforeEach ->
    this.risk =
      title: 'Title'
      findings: ['Dummy finding']

  it 'is valid when it has a title and at least one finding', ->
    expect(validateRisk(this.risk)).toEqual {}

  it 'is invalid when it has no title', ->
    this.risk.title = ''
    expect(validateRisk(this.risk)).toEqual title_error

  it 'is invalid when it has no findings', ->
    this.risk.findings = []
    expect(validateRisk(this.risk)).toEqual
      findings: jasmine.any(String)

  it 'is invalid when it has no title and no findings', ->
    expect(validateRisk({title: '', findings: []})).toEqual
      title: jasmine.any(String)
      findings: jasmine.any(String)

  it 'is invalid when the findings are not an array of strings', ->
    expect(validateRisk, {title: 'Title', findings: [10]}).toThrowError Match.Error


describe 'A measure', ->

  beforeEach ->
    this.measure =
      title: 'Title'
      risks: ['Dummy risk']

  it 'is valid when it has a title and at least one risk', ->
    expect(validateMeasure(this.measure)).toEqual {}

  it 'is invalid when it has no title', ->
    this.measure.title = ''
    expect(validateMeasure(this.measure)).toEqual title_error

  it 'is invalid when it has no risks', ->
    this.measure.risks = []
    expect(validateMeasure(this.measure)).toEqual
      risks: jasmine.any(String)

  it 'is invalid when it has no title and no risks', ->
    expect(validateMeasure({title: '', risks: []})).toEqual
      title: jasmine.any(String)
      risks: jasmine.any(String)

  it 'is invalid when the risks are not an array of strings', ->
    expect(validateMeasure, {title: 'Title', risks: [10]}).toThrowError Match.Error


describe 'A checklist', ->

  beforeEach ->
    this.checklist =
      title: 'Title'
      owners: ['Dummy user']

  it 'is valid when it has a title and at least one owner', ->
    expect(validateChecklist(this.checklist)).toEqual {}

  it 'is invalid when it has no title', ->
    this.checklist.title = ''
    expect(validateChecklist(this.checklist)).toEqual title_error

  it 'is invalid when it has no owners', ->
    this.checklist.owners = []
    expect(validateChecklist(this.checklist)).toEqual
      owners: jasmine.any(String)

  it 'is invalid when it has no title and no owners', ->
    expect(validateChecklist({title: '', owners: []})).toEqual
      title: jasmine.any(String)
      owners: jasmine.any(String)


describe 'A criterium', ->

  it 'is valid when it has a title', ->
    expect(validateCriterium({title: 'Title'})).toEqual {}

  it 'is invalid when it has no title', ->
    expect(validateCriterium({title: ''})).toEqual title_error
