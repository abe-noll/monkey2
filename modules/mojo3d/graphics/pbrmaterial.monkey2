
Namespace mojo3d.graphics

#rem monkeydoc The PbrMaterial class.
#end
Class PbrMaterial Extends Material
	
	#rem monkeydoc Creates a new pbr material.
	
	All properties default to white or '1' except for emissive factor which defaults to black. If you set an emissive texture, don't forget to set emissive factor to white to 'enable' it.
	
	The metalness value should be stored in the 'blue' channel of the metalness texture if the texture has multiple color channels.
	
	The roughness value should be stored in the 'green' channel of the metalness texture if the texture has multiple color channels.
	
	The occlusion value should be stored in the 'red' channel of the occlusion texture if the texture has multiple color channels.
	
	The above last 3 rules allow you to pack metalness, roughness and occlusion into a single texture.
	
	#end
	Method New( boned:Bool=False )
		Super.New( Shader.Open( boned ? "boned-material" Else "material" ) )
		
		ColorTexture=Texture.ColorTexture( Color.White )
		ColorFactor=Color.White
		
		EmissiveTexture=Texture.ColorTexture( Color.White )
		EmissiveFactor=Color.Black
	
		MetalnessTexture=Texture.ColorTexture( Color.White )
		MetalnessFactor=1.0
		
		RoughnessTexture=Texture.ColorTexture( Color.White )
		RoughnessFactor=1.0
		
		OcclusionTexture=Texture.ColorTexture( Color.White )
		
		NormalTexture=Texture.ColorTexture( New Color( 0.5,0.5,1.0,0.0 ) )
	End
	
	Method New( material:PbrMaterial )
		Super.New( material )
	End
	
	Method New( color:Color,metalness:Float=0.0,roughness:Float=1.0 )
	
		Self.New()
		
		ColorFactor=color
		MetalnessFactor=metalness
		RoughnessFactor=roughness
	End
	
	#rem monkeydoc Creates a copy of the pbr material.
	#end
	Method Copy:PbrMaterial() Override
	
		Return New PbrMaterial( Self )
	End
	
	Property ColorTexture:Texture()
	
		Return Uniforms.GetTexture( "ColorTexture" )
		
	Setter( texture:Texture )
	
		Uniforms.SetTexture( "ColorTexture",texture )
	End
	
	Property ColorFactor:Color()
	
		Return Uniforms.GetColor( "ColorFactor" )
		
	Setter( color:Color )
	
		Uniforms.SetColor( "ColorFactor",color )
	End
	
	Property EmissiveTexture:Texture()
	
		Return Uniforms.GetTexture( "EmissiveTexture" )
		
	Setter( texture:Texture )
	
		Uniforms.SetTexture( "EmissiveTexture",texture )
	End
	
	Property EmissiveFactor:Color()
	
		Return Uniforms.GetColor( "EmissiveFactor" )
		
	Setter( color:Color )
	
		Uniforms.SetColor( "EmissiveFactor",color )
	End
	
	Property MetalnessTexture:Texture()
	
		Return Uniforms.GetTexture( "MetalnessTexture" )
		
	Setter( texture:Texture )
	
		Uniforms.SetTexture( "MetalnessTexture",texture )
	End

	Property MetalnessFactor:Float()
	
		Return Uniforms.GetFloat( "MetalnessFactor" )
		
	Setter( factor:Float )

		Uniforms.SetFloat( "MetalnessFactor",factor )
	End
	
	Property RoughnessTexture:Texture()
	
		Return Uniforms.GetTexture( "RoughnessTexture" )
		
	Setter( texture:Texture )
	
		Uniforms.SetTexture( "RoughnessTexture",texture )
	End
	
	Property RoughnessFactor:Float()
	
		Return Uniforms.GetFloat( "RoughnessFactor" )
		
	Setter( factor:Float )
	
		Uniforms.SetFloat( "RoughnessFactor",factor )
	End

	Property OcclusionTexture:Texture()
	
		Return Uniforms.GetTexture( "occlusion" )
		
	Setter( texture:Texture )
	
		Uniforms.SetTexture( "OcclusionTexture",texture )
	End
	
	Property NormalTexture:Texture()
	
		Return Uniforms.GetTexture( "NormalTexture" )
		
	Setter( texture:Texture )
	
		Uniforms.SetTexture( "NormalTexture",texture )
	End

	#rem monkeydoc Loads a PbrMaterial from a 'file'.
	
	A .pbr file is actually a directory containing a number of textures in png format. These textures are:
	
	color.png (required)
	emissive.png
	metalness.png
	roughness.png
	occlusion.png
	normal.png
	
	#end
	Function Load:PbrMaterial( path:String )
		
		Local flags:TextureFlags=TextureFlags.WrapST|TextureFlags.FilterMipmap
		
		
		Local material:=New PbrMaterial
		
		Local texture:=Texture.Load( path+"/color.png",flags )
		If texture
			material.ColorTexture=texture
		Endif
		
		texture=Texture.Load( path+"/emissive.png",flags )
		If texture
			material.EmissiveTexture=texture
			material.EmissiveFactor=Color.White
		Endif
		
		texture=Texture.Load( path+"/metalness.png",flags )
		If texture
			material.MetalnessTexture=texture
		Endif
		
		texture=Texture.Load( path+"/roughness.png",flags )
		If texture
			material.RoughnessTexture=texture
		Endif
		
		texture=Texture.Load( path+"/occlusion.png",flags )
		If texture
			material.OcclusionTexture=texture
		Endif
		
		texture=Texture.Load( path+"/normal.png",flags )
'		If Not texture texture=Texture.Load( path+"/unormal.png",flags|TextureFlags.InvertGreen )
		If texture
			material.NormalTexture=texture
		Endif
		
		Return material
	End
	
End