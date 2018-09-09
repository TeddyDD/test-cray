module RGuiLayout
	class Layout
		@anchors : Array(Anchor)
		@controls : Array(Control)
		@mounts : Array(Layout)
  	
		def initialize(rgl : String)
  		
		end

		def draw
		end

		def mount(control : String, layout : Layout)
		end

		def [](name : String)
		end
		
	end

	struct Control
		property rectangle : LibRay::Rectangle  	
		property enabled : Bool
		property name : String
		@id : Int
		@anchor_id : Int
	end

	struct Anchor
		property x : Float
		property y : Float
		property enabled : Bool
		@id : Int
	end
		
end
