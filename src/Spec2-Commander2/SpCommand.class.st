"
I am a command decorator adding informations useful when for usage in context of a Spec application.

Basically, I add:
- an #icon (#blank by default)
- a #shortcutKey (optional)
- a #displayStrategy to handle how to show the command if it is not executable on a context (default is to be disabled)
- a #positionStrategy to handle on which side presenter with left and right side I should be (default is left)

"
Class {
	#name : #SpCommand,
	#superclass : #CmCommandDecorator,
	#instVars : [
		'iconProvider',
		'iconName',
		'shortcutKey',
		'displayStrategy',
		'positionStrategy'
	],
	#category : #'Spec2-Commander2-Core'
}

{ #category : #converting }
SpCommand >> asButtonPresenter [
	self flag: #TODO. "Needs to use inform user display strategy when available, no other available strategy can be used in this context. See issue #705"
	^ SpButtonPresenter new
		label: self name;
		help: self description;
		in: [ :button |
			self hasIcon
				ifTrue: [ button iconName: self iconName ] ];
		action: [ self execute ]
		yourself
		
]

{ #category : #configuring }
SpCommand >> beDisabledWhenCantBeRun [
	self displayStrategy: SpDisableWhenCantBeRun new
]

{ #category : #configuring }
SpCommand >> beDisplayedOnLeftSide [
	positionStrategy := SpLeftPositionStrategy new
]

{ #category : #configuring }
SpCommand >> beDisplayedOnRightSide [
	positionStrategy := SpRightPositionStrategy new
]

{ #category : #configuring }
SpCommand >> beHiddenWhenCantBeRun [
	self displayStrategy: SpHideWhenCantBeRun new
]

{ #category : #displaying }
SpCommand >> displayIn: aMenuGroupOrPresenter do: aBlock [
	self displayStrategy display: self in: aMenuGroupOrPresenter do: aBlock
]

{ #category : #accessing }
SpCommand >> displayStrategy [
	^ displayStrategy
]

{ #category : #accessing }
SpCommand >> displayStrategy: anObject [
	displayStrategy := anObject
]

{ #category : #hooks }
SpCommand >> execute [
	[ super execute ]
		on: SpInteractionError
		do: [ :notificationOrError | notificationOrError actForSpec ]
]

{ #category : #testing }
SpCommand >> hasIcon [

	^ self iconName isNotNil
]

{ #category : #testing }
SpCommand >> hasShortcutKey [

	^ shortcutKey isNotNil
]

{ #category : #accessing }
SpCommand >> icon [
	self iconName ifNil: [ ^ nil ].
	
	^ self iconNamed: self iconName
]

{ #category : #accessing }
SpCommand >> iconName [
	^ iconName
]

{ #category : #accessing }
SpCommand >> iconName: aSymbol [ 
	iconName := aSymbol
]

{ #category : #configuring }
SpCommand >> iconName: aString from: anIconProvider [ 
	self iconProvider: anIconProvider.
	self iconName: aString.
]

{ #category : #accessing }
SpCommand >> iconNamed: aSymbol [
	^ self iconProvider iconNamed: aSymbol
]

{ #category : #accessing }
SpCommand >> iconProvider [
	^ iconProvider ifNil: [ iconProvider := Smalltalk ui icons ]
]

{ #category : #accessing }
SpCommand >> iconProvider: anObject [
	iconProvider := anObject
]

{ #category : #initialization }
SpCommand >> initialize [ 

	super initialize.
	self beDisabledWhenCantBeRun.
	self beDisplayedOnLeftSide
]

{ #category : #accessing }
SpCommand >> positionStrategy [
	^ positionStrategy
]

{ #category : #accessing }
SpCommand >> shortcutKey [
	^ shortcutKey ifNil: [ CmNoShortcutIsDefined signalCommand: self ]
]

{ #category : #accessing }
SpCommand >> shortcutKey: aString [
 	shortcutKey := aString 
]
