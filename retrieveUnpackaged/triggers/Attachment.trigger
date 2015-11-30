trigger Attachment on Attachment (before insert, after insert) {
	if(trigger.isBefore){
		if(trigger.isInsert){
			AttachmentHelper.createcustomAttachment(trigger.new);
		}
	}
	if(trigger.isAfter){
		if(trigger.isInsert){
			AttachmentHelper.updateAttachmentId(trigger.new);
		}
	}
}