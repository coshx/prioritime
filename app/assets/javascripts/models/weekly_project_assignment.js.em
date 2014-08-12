# for more details see: http://emberjs.com/guides/models/defining-models/

class Prioritime.WeeklyProjectAssignment extends DS.Model
  projectAssignment: DS.attr 'references,'
  weekStart: DS.attr 'date,'
  daysWorking: DS.attr 'number'
