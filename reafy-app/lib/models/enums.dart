enum NewExpenseTemplateStateEnum {
  list,
  input,
  intent,
  type,
  overview,
  participant
}

enum ExpenseTemplateTypeEnum {
  fradragsberettigetRepresentasjon,
  ikkeFradragsberettigetRepresentasjon,
  velferd
}

extension ExpenseTemplateTypeEnumStringExtension on ExpenseTemplateTypeEnum {
  String get stringValues {
    switch (this) {
      case ExpenseTemplateTypeEnum.fradragsberettigetRepresentasjon:
        return 'Fradragsberettiget representasjon';
      case ExpenseTemplateTypeEnum.ikkeFradragsberettigetRepresentasjon:
        return 'Ikke fradragsberettiget representasjon';
      case ExpenseTemplateTypeEnum.velferd:
        return 'Velferd';
    }
  }

  ExpenseTemplateTypeEnum get enumValues {
    switch (this) {
      case 'Fradragsberettiget representasjon':
        return ExpenseTemplateTypeEnum.fradragsberettigetRepresentasjon;
      case 'Ikke fradragsberettiget representasjon':
        return ExpenseTemplateTypeEnum.ikkeFradragsberettigetRepresentasjon;
      case 'Velferd':
        return ExpenseTemplateTypeEnum.velferd;
      default:
        return ExpenseTemplateTypeEnum.velferd;
    }
  }
}

enum ExpenseTemplateIntentEnum {
  meeting,
  clientHospitality,
  recruitment,
  partnerHospitality,
  other
}

extension ExpenseTemplateIntentEnumStringExtension
    on ExpenseTemplateIntentEnum {
  String get stringValues {
    switch (this) {
      case ExpenseTemplateIntentEnum.meeting:
        return 'Møteservering';
      case ExpenseTemplateIntentEnum.clientHospitality:
        return 'Kundepleie';
      case ExpenseTemplateIntentEnum.recruitment:
        return 'Rekrutering';
      case ExpenseTemplateIntentEnum.partnerHospitality:
        return 'Partnerpleie';
      case ExpenseTemplateIntentEnum.other:
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
