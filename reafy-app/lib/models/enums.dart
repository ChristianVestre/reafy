enum NewExpenseTemplateStateEnum { list, input, intent, type, overview }

enum NewExpenseTemplateTypeEnum {
  fradragsberettigetRepresentasjon,
  ikkeFradragsberettigetRepresentasjon,
  velferd
}

extension NewExpenseTemplateTypeEnumStringExtension
    on NewExpenseTemplateTypeEnum {
  String get stringValues {
    switch (this) {
      case NewExpenseTemplateTypeEnum.fradragsberettigetRepresentasjon:
        return 'Fradragsberettiget representasjon';
      case NewExpenseTemplateTypeEnum.ikkeFradragsberettigetRepresentasjon:
        return 'Ikke fradragsberettiget representasjon';
      case NewExpenseTemplateTypeEnum.velferd:
        return 'Velferd';
    }
  }
}

enum NewExpenseTemplateIntentEnum {
  meeting,
  clientHospitality,
  recruitment,
  partnerHospitality,
  other
}

extension NewExpenseTemplateIntentEnumStringExtension
    on NewExpenseTemplateIntentEnum {
  String get stringValues {
    switch (this) {
      case NewExpenseTemplateIntentEnum.meeting:
        return 'Møteservering';
      case NewExpenseTemplateIntentEnum.clientHospitality:
        return 'Kundepleie';
      case NewExpenseTemplateIntentEnum.recruitment:
        return 'Rekrutering';
      case NewExpenseTemplateIntentEnum.partnerHospitality:
        return 'Partnerpleie';
      case NewExpenseTemplateIntentEnum.other:
        return 'Annet';
    }
  }
}
/*
  'Møteservering',
  'Kundepleie',
  'Rekrutering',
  'Partnerpleie',
  'Other'
*/

enum NewExpenseTemplateSearchFilterEnum { company, personal, partners, none }
