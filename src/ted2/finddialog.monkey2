
Namespace ted2

Class FindDialog Extends Dialog

	Method New( actions:FindActions )
	
		_findField=New TextField
		
		_replaceField=New TextField
		
		_findField.Entered+=Lambda()
			actions.findNext.Trigger()
		End

		_findField.Tabbed+=_replaceField.MakeKeyView

		_replaceField.Tabbed+=_findField.MakeKeyView
		
		_caseSensitive=New CheckButton( "Case sensitive" )
		_caseSensitive.Layout="float"
		
'		_escapedText=New CheckButton( "Escaped text" )

		Local table:=New TableView( 2,2 )
		table[0,0]=New Label( "Find" )
		table[1,0]=_findField
		table[0,1]=New Label( "Replace" )
		table[1,1]=_replaceField 
		
		_docker=New DockingView
		_docker.AddView( table,"top" )
		_docker.AddView( _caseSensitive,"top" )
'		_docker.AddView( _escapedText,"top" )
		_docker.AddView( New Label( " " ),"top" )
		
		Title="Find/Replace"
		
		MaxSize=New Vec2i( 512,0 )
		
		ContentView=_docker
		
		AddAction( actions.findNext )
		AddAction( actions.findPrevious )
		AddAction( actions.replace )
		AddAction( actions.replaceAll )
		
		Local close:=AddAction( "Close" )
		SetKeyAction( Key.Escape,close )
		close.Triggered=Close
		
		_findField.Activated+=_findField.MakeKeyView
		
		Deactivated+=MainWindow.UpdateKeyView
	End
	
	Property FindText:String()
	
		Return _findField.Text
	End
	
	Property ReplaceText:String()
	
		Return _replaceField.Text
	End
	
	Property CaseSensitive:Bool()
	
		Return _caseSensitive.Checked
	End
	
	Private
	
	Field _findField:TextField
	Field _replaceField:TextField
	Field _caseSensitive:CheckButton
	Field _escapedText:CheckButton

	Field _docker:DockingView

End
