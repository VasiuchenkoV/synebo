trigger CaseTrigger on Case (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            CaseTriggerHandler.updateAccountFields(new Map<Id, Case>(), trigger.new);
        } else if (Trigger.isUpdate) {
            CaseTriggerHandler.updateAccountFields(trigger.oldMap,trigger.new);
        }
    }
}