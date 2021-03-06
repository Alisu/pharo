Class {
	#name : #SpCodeInspectItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #default }
SpCodeInspectItCommand class >> defaultName [

	^ 'Inspect it'
]

{ #category : #default }
SpCodeInspectItCommand class >> defaultShortcutKey [

	^ $i meta
]

{ #category : #execution }
SpCodeInspectItCommand >> execute [
	"Treat the current text selection as an expression; evaluate it."
	
	self evaluateSelectionAndDo: [ :result | 
		self inspectObject: result ]
]

{ #category : #execution }
SpCodeInspectItCommand >> inspectObject: anObject [
	anObject inspect
]
