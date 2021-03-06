
Namespace myapp

#Import "<std>"
#Import "<mojo>"
#Import "<mojo3d>"

#Import "assets/"

#Import "util"

Using std..
Using mojo..
Using mojo3d..

Const MaxAnisotropy:=16
			
Class MyWindow Extends Window
	
	Field _scene:Scene
	
	Field _camera:Camera
	
	Field _light:Light
	
	Field _ground:Model
	
	Method New( title:String="Simple mojo app",width:Int=640,height:Int=480,flags:WindowFlags=WindowFlags.Resizable )

		Super.New( title,width,height,flags )
		
		SetConfig( "MOJO_TEXTURE_MAX_ANISOTROPY",MaxAnisotropy )
		
		'create scene
		'		
		_scene=Scene.GetCurrent()
		
		_scene.EnvColor=Color.Black
		_scene.ClearColor=Color.Black
		_scene.AmbientLight=Color.Black

		'create camera
		'
		_camera=New Camera
		_camera.Near=1
		_camera.Far=1000
		_camera.Move( 0,2,0 )

		'create light
		'
		'_light=New Light
		'_light.RotateX( 90 )
		
		'createa simple 'grid' texture
		'
		Local pixmap:=New Pixmap( 16,16 )
		pixmap.Clear( Color.Black )
		For Local i:=0 Until 16
			pixmap.SetPixelARGB( i,0,~0 )
			pixmap.SetPixelARGB( 0,i,~0 )
		Next
		Local texture:=New Texture( pixmap,TextureFlags.FilterMipmap|TextureFlags.WrapST )
		
		'create material
		'
		Local material:=New PbrMaterial( Color.Black )
		material.EmissiveTexture=texture
		material.EmissiveFactor=Color.Red

		material.ScaleTextureMatrix( 500,500 )
		
		'create ground
		'		
		_ground=Model.CreateBox( New Boxf( -500,-1,-500,500,0,500 ),10,10,10,material )
	End
	
	Method OnRender( canvas:Canvas ) Override

		RequestRender()
		
		util.Fly( _camera,Self )
		
		_scene.Render( canvas,_camera )
	End
	
End

Function Main()
	
	New AppInstance
	
	New MyWindow
	
	App.Run()
End
