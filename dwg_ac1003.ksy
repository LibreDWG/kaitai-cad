meta:
  id: dwg_ac1003
  title: AutoCAD drawing (AC1003)
  application: AutoCAD
  file-extension:
    - dwg
  license: CC0-1.0
  xref:
    justsolve: DWG
    pronom:
      fmt: 29
    mime:
      - application/x-dwg
      - image/vnd.dwg
    wikidata: Q27863121
  endian: le
seq:
  - id: header
    type: header
  - id: entities
    type: real_entities
    size: header.entities_end - header.entities_start
  - id: blocks
    type: block
    repeat: expr
    repeat-expr: header.table_block.items
  - id: layers
    type: layer
    repeat: expr
    repeat-expr: header.table_layer.items
  - id: styles
    type: style
    repeat: expr
    repeat-expr: header.table_style.items
  - id: linetypes
    type: linetype
    repeat: expr
    repeat-expr: header.table_linetype.items
  - id: views
    type: view
    repeat: expr
    repeat-expr: header.table_view.items
  - id: block_entities
    type: real_entities
    size: header.blocks_size
  - id: todo
    size-eos: true
    repeat: eos
    if: not _io.eof
types:
  block:
    seq:
      - id: flag
        type: block_flag
        doc: BLOCK/70
      - id: block_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: BLOCK/2
      - id: u2
        type: s1
      - id: u3
        type: s1
      - id: u4
        type: s1
      - id: u5
        type: s1
      - id: u6
        type: s1
  block_flag:
    seq:
      - id: flag1
        type: b1
      - id: flag2
        type: b1
      - id: flag3
        type: b1
      - id: flag4
        type: b1
      - id: flag5
        type: b1
      - id: flag6
        type: b1
      - id: flag7
        type: b1
      - id: flag8
        type: b1
  header:
    seq:
      - id: magic
        contents: [0x41, 0x43, 0x31, 0x30, 0x30, 0x33]
        doc: 0x0000-0x0005, $ACADVER
      - id: zeros
        size: 6
      - id: zero_one_or_three
        type: s1
      - id: unknown_3
        type: s2
      - id: num_sections
        type: s2
      - id: num_header_vars
        type: s2
      - id: dwg_version
        type: s1
      - id: entities_start
        type: s4
      - id: entities_end
        type: s4
      - id: blocks_start
        type: s4
      - id: blocks_size_raw
        type: u4
      - id: blocks_end
        type: s4
      - id: unknown4b
        size: 2
      - id: unknown4c
        size: 2
      - id: table_block
        type: table
      - id: table_layer
        type: table
      - id: table_style
        type: table
      - id: table_linetype
        type: table
      - id: table_view
        type: table
      - id: variables
        type: header_variables
    instances:
      blocks_size_unknown:
         value: (blocks_size_raw & 0xff000000) >> 24
      blocks_size:
         value: (blocks_size_raw & 0x00ffffff)
  table:
    seq:
      - id: item_size
        type: u2
      - id: items
        type: u2
      - id: unknown
        size: 2
      - id: begin
        type: u4
  header_variables:
    seq:
      - id: insertion_base
        type: point_3d
        doc: 0x005e-0x0075, $INSBASE/10|20|30
      - id: num_entities
        type: u2
        doc: 0x0076-0x0077
      - id: drawing_first
        type: point_3d
        doc: 0x0078-0x008f, $EXTMIN/10|20|30
      - id: drawing_second
        type: point_3d
        doc: 0x0090-0x00a7, $EXTMAX/10|20|30
      - id: limits_min
        type: point_2d
        doc: 0x00a8-0x00b7, $LIMMIN/10|20
      - id: limits_max
        type: point_2d
        doc: 0x00b8-0x00c7, $LIMMAX/10|20
      - id: view_ctrl
        type: point_3d
        doc: 0x00c8-0x00da, $VIEWCTRL/10|20|30
      - id: view_size
        type: f8
        doc: 0x00e0-0x00e7
      - id: snap
        type: s2
        doc: 0x00e8-0x00e9, $SNAPMODE
      - id: snap_resolution
        type: point_2d
        doc: 0x00ea-0x00f9, $SNAPUNIT/10|20
      - id: snap_base
        type: point_2d
        doc: 0x00fa-0x0109, $SNAPBASE/10|20
      - id: snap_angle
        type: f8
        doc: 0x010a-0x0111, $SNAPANG
      - id: snap_style
        type: s2
        doc: 0x0112-0x0113, $SNAPSTYLE
      - id: snap_iso_pair
        type: s2
        enum: iso_plane
        doc: 0x0114-0x0115, $SNAPISOPAIR
      - id: grid
        type: s2
        doc: 0x0116-0x0117, $GRIDMODE
      - id: grid_unit
        type: point_2d
        doc: 0x0118-0x0127, $GRIDUNIT/10|20
      - id: ortho
        type: s2
        doc: 0x0128-0x0129, $ORTHOMODE
      - id: regen
        type: s2
        doc: 0x012a-0x012b, $REGENMODE
      - id: fill
        type: s2
        doc: 0x012c-0x012d, $FILLMODE
      - id: qtext
        type: s2
        doc: 0x012e-0x012f, $QTEXTMODE
      - id: drag
        type: s2
        doc: 0x0130-0x0131, $DRAGMODE
      - id: linetype_scale
        type: f8
        doc: 0x0132-0x0139, $LTSCALE
      - id: text_size
        type: f8
        doc: 0x013a-0x0141, $TEXTSIZE
      - id: trace_width
        type: f8
        doc: 0x0142-0x0149, $TRACEWID
      - id: current_layer_index
        type: s2
        doc: 0x014a-0x014b, $CLAYER
      - id: current_color_convert
        type: f8
        doc: 0x014c-0x0153
      - id: unknown7a
        size: 2
        doc: 0x0154-0x0155
      - id: unknown7b
        size: 2
        doc: 0x0156-0x0157
      - id: unknown7c
        size: 2
        doc: 0x0158-0x0159
      - id: unknown7d
        size: 2
        doc: 0x015a-0x015b
      - id: unknown8
        type: f8
        doc: 0x015c-0x0163
      - id: linear_units_format
        enum: unit_types
        type: s2
        doc: 0x0164-0x0165, $LUNITS
      - id: linear_units_precision
        type: s2
        doc: 0x0166-0x0167, $LUPREC
      - id: axis
        type: s2
        doc: 0x0168-0x0169, $AXISMODE
      - id: axis_value
        type: point_2d
        doc: 0x016a-0x0179, $AXISUNIT/10|20
      - id: sketch_increment
        type: f8
        doc: 0x017a-0x0181, $SKETCHINC
      - id: fillet_radius
        type: f8
        doc: $FILLETRAD
      - id: units_for_angles
        enum: units_for_angles
        type: s2
        doc: $AUNITS
      - id: angular_precision
        type: s2
        doc: $AUPREC
      - id: text_style_index
        type: s2
        doc: 0x018e-0x018f, $TEXTSTYLE (index)
      - id: osnap
        enum: osnap_modes
        type: s2
        doc: 0x0190-0x0191, $OSMODE
      - id: attributes
        enum: attributes
        type: s2
        doc: 0x0192-0x0193, $ATTMODE
      - id: menu
        size: 15
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: 0x0194-0x01a2, $MENU
      - id: dim_scale
        type: f8
        doc: 0x01a3-0x01aa, $DIMSCALE
      - id: dim_arrowhead_size
        type: f8
        doc: $DIMASZ
      - id: dim_extension_line_offset
        type: f8
        doc: $DIMEXO
      - id: dim_baseline_spacing
        type: f8
        doc: $DIMDLI
      - id: dim_extension_line_extend
        type: f8
        doc: $DIMEXE
      - id: dim_maximum_tolerance_limit
        type: f8
        doc: 0x01cb-0x01d2, $DIMTP
      - id: dim_minimum_tolerance_limit
        type: f8
        doc: 0x01d3-0x01da, $DIMTM
      - id: dim_text_height
        type: f8
        doc: 0x01db-0x01e2, $DIMTXT
      - id: dim_center_mark_control
        type: f8
        doc: 0x01e3-0x01ea, $DIMCEN
      - id: dim_oblique_stroke_size
        type: f8
        doc: 0x01eb-0x01f2, $DIMTSZ
      - id: dim_tolerances
        type: s1
        doc: 0x01f3, $DIMTOL
      - id: dim_limits_default_text
        type: s1
        doc: 0x01f4, $DIMLIM
      - id: dim_text_ext_inside_line_position
        type: s1
        doc: 0x01f5, $DIMTIH
      - id: dim_text_ext_outside_line_position
        type: s1
        doc: 0x01f6, $DIMTOH
      - id: dim_extension_line_first_suppress
        type: s1
        doc: 0x01f7, $DIMSE1
      - id: dim_extension_line_second_suppress
        type: s1
        doc: 0x01f8, $DIMSE2
      - id: dim_text_vertical_position
        type: s1
        doc: 0x01f9, $DIMTAD
      - id: limits_check
        enum: limits_check
        type: s2
        doc: 0x01fa-0x01fb, $LIMCHECK
      - id: unknown10
        size: 45
      - id: elevation
        type: f8
        doc: 0x0229-0x0230, $ELEVATION
      - id: thickness
        type: f8
        doc: 0x0231-0x0238, $THICKNESS
      - id: view_point
        type: point_3d
        doc: 0x0239-0x0251, $VIEWDIR/10|20|30
      - id: unknown_repeating
        type: unknown_repeating
        doc: 0x0252-0x02e0
      - id: unknown29
        type: s2
        doc: 0x02e1-0x02e2
      - id: blip
        type: s2
        doc: 0x02e3-0x02e4, $BLIPMODE
      - id: dim_suppression_of_zeros
        type: s1
        doc: 0x02e5, $DIMZIN
      - id: dim_rounding
        type: f8
        doc: 0x02e6-0x02ed, $DIMRND
      - id: dim_extension_line_extend2
        type: f8
        doc: 0x02ee-0x02f5, $DIMDLE
      - id: dim_arrowhead_block
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: $DIMBLK
      - id: unknown30
        type: s1
      - id: circle_zoom_percent
        type: s2
        doc: 0x0317-0x0318
      - id: coordinates
        enum: coordinates
        type: s2
        doc: 0x0319-0x031a, $COORDS
      - id: current_color
        enum: current_color
        type: s2
        doc: 256d - bylayer, 0d - byblock, other index (1-255), $CECOLOR
      - id: current_linetype
        type: s2
        doc: 256d - bylayer, 255d - byblock, other index, $CELTYPE
      - id: create_date_days
        type: u4
        doc: $TDCREATE/days
      - id: create_date_ms
        type: u4
        doc: $TDCREATE/ms
      - id: update_date_days
        type: u4
        doc: $TDUPDATE/days
      - id: update_date_ms
        type: u4
        doc: $TDUPDATE/ms
      - id: total_editing_time_days
        type: u4
        doc: $TDINDWG/days
      - id: total_editing_time_ms
        type: u4
        doc: $TDINDWG/ms
      - id: user_elapsed_timer_days
        type: u4
        doc: $TDUSRTIMER/days
      - id: user_elapsed_timer_ms
        type: u4
        doc: $TDUSRTIMER/ms
      - id: user_timer
        type: s2
        doc: 0x033f-0x0340, $USRTIMER
      - id: fast_zoom
        type: s1
        doc: 0x0341, $FASTZOOM
      - id: unknown33
        size: 1
      - id: sketch_type
        type: s1
        doc: 0x0343, $SKPOLY
      - id: unknown33b
        size: 7
      - id: unknown34
        type: f8
      - id: angle_base
        type: f8
        doc: 0x0353-0x035a, $ANGBASE
      - id: angle_direction
        enum: angle_direction
        type: s2
        doc: 0x035b-0x035c, $ANGDIR
      - id: point_mode
        type: s2
        doc: 0x035d-0x035e, $PDMODE
      - id: point_size
        type: f8
        doc: $PDSIZE
      - id: polyline_width
        type: f8
        doc: $PLINEWID
      - id: user_integer_1
        type: s2
        doc: 0x035f-0x0360, $USERI1
      - id: user_integer_2
        type: s2
        doc: 0x0361-0x0362, $USERI2
      - id: user_integer_3
        type: s2
        doc: 0x0363-0x0364, $USERI3
      - id: user_integer_4
        type: s2
        doc: 0x0365-0x0366, $USERI4
      - id: user_integer_5
        type: s2
        doc: 0x0367-0x0368, $USERI5
      - id: user_real_1
        type: f8
        doc: $USERR1
      - id: user_real_2
        type: f8
        doc: $USERR2
      - id: user_real_3
        type: f8
        doc: $USERR3
      - id: user_real_4
        type: f8
        doc: $USERR4
      - id: user_real_5
        type: f8
        doc: $USERR5
      - id: dim_alternate_units
        type: s1
        doc: 0x03a1, $DIMALT
      - id: dim_alternate_units_decimal_places
        type: s1
        doc: 0x03a2, $DIMALTD
      - id: dim_associative
        type: s1
        doc: 0x03a3, $DIMASO
      - id: dim_sho
        type: s1
        doc: 0x03a4, $DIMSHO
      - id: dim_measurement_postfix
        size: 16
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: $DIMPOST, TODO And prefix?
      - id: dim_alternate_measurement_postfix
        size: 16
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: $DIMAPOST, TODO And prefix
      - id: dim_alternate_units_multiplier
        type: f8
        doc: 0x03c5-0x03cc, $DIMALTF
        if: _parent.num_header_vars == 122
      - id: dim_linear_measurements_scale_factor
        type: f8
        doc: 0x03cd-0x03d4, $DIMLFAC
        if: _parent.num_header_vars == 122
    instances:
      create_date:
        value: create_date_days + (create_date_ms / 86400000.0)
      update_date:
        value: update_date_days + (update_date_ms / 86400000.0)
  unknown_repeating:
    seq:
      - id: unknown_repeating1
        type: f8
      - id: unknown_repeating2
        type: f8
      - id: unknown_repeating3
        type: f8
      - id: unknown_repeating4
        type: f8
      - id: unknown_repeating5
        type: f8
      - id: unknown_repeating6
        type: f8
      - id: unknown_repeating7
        type: f8
      - id: unknown_repeating8
        type: f8
      - id: unknown_repeating9
        type: f8
      - id: unknown_repeating10
        type: f8
      - id: unknown_repeating11
        type: f8
      - id: unknown_repeating12
        type: f8
      - id: unknown_repeating13
        type: f8
      - id: unknown_repeating14
        type: f8
      - id: unknown_repeating15
        type: f8
      - id: unknown_repeating16
        type: f8
      - id: unknown_repeating17
        type: f8
      - id: unknown_repeating18
        type: f8
  entity:
    seq:
      - id: entity_type
        type: s1
        enum: entities
      - id: data
        type:
          switch-on: entity_type
          cases:
            'entities::arc': entity_arc
            'entities::attdef': entity_attdef
            'entities::attrib': entity_attrib
            'entities::block_begin': entity_block_begin
            'entities::block_end': entity_block_end
            'entities::insert' : entity_insert
            'entities::circle': entity_circle
            'entities::dim': entity_dim
            'entities::face3d': entity_face3d
            'entities::line': entity_line
            'entities::line3d': entity_line3d
            'entities::point': entity_point
            'entities::polyline': entity_polyline
            'entities::polyline2': entity_polyline
            'entities::seqend': entity_seqend
            'entities::shape': entity_shape
            'entities::solid': entity_solid
            'entities::text': entity_text
            'entities::trace': entity_trace
            'entities::vertex': entity_vertex
            _: entity_tmp
  entity_mode:
    seq:
      - id: entity_mode1
        type: b1
      - id: entity_mode2
        type: b1
      - id: entity_mode3
        type: b1
      - id: entity_mode4
        type: b1
      - id: entity_thickness_flag
        type: b1
      - id: entity_elevation_flag
        type: b1
      - id: entity_linetype_flag
        type: b1
      - id: entity_color_flag
        type: b1
  entity_common:
    seq:
      - id: entity_mode
        type: entity_mode
      - id: entity_size
        type: s2
      - id: entity_layer_index
        type: s1
      - id: flag1
        type: s1
      - id: flag2_1
        type: b1
      - id: flag2_2
        type: b1
      - id: flag2_3
        type: b1
      - id: flag2_4
        type: b1
      - id: flag2_5
        type: b1
      - id: flag2_6
        type: b1
      - id: flag2_7
        type: b1
      - id: flag2_8
        type: b1
      - id: flag3_1
        type: b1
      - id: flag3_2
        type: b1
      - id: flag3_3
        type: b1
      - id: flag3_4
        type: b1
      - id: flag3_5
        type: b1
      - id: flag3_6
        type: b1
      - id: flag3_7
        type: b1
      - id: flag3_8
        type: b1
      - id: entity_color
        type: s1
        if: entity_mode.entity_color_flag
      - id: entity_linetype_index
        type: s1
        if: entity_mode.entity_linetype_flag
      - id: entity_elevation
        type: f8
        if: entity_mode.entity_elevation_flag
      - id: entity_thickness
        type: f8
        if: entity_mode.entity_thickness_flag
  entity_arc:
    seq:
      - id: entity_common
        type: entity_common
      - id: x
        type: f8
        doc: ARC/10
      - id: y
        type: f8
        doc: ARC/20
      - id: radius
        type: f8
        doc: ARC/40
      - id: angle_from
        type: f8
        doc: ARC/50
      - id: angle_to
        type: f8
        doc: ARC/51
  entity_attdef:
    seq:
      - id: entity_common
        type: entity_common
      - id: start_point
        type: point_2d
        doc: ATTDEF/10|20
      - id: height
        type: f8
        doc: ATTDEF/40
      - id: default_size
        type: s2
      - id: default
        size: default_size
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: ATTDEF/1
      - id: prompt_size
        type: s2
      - id: prompt
        size: prompt_size
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: ATTDEF/3
      - id: tag_size
        type: s2
      - id: tag
        size: tag_size
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: ATTDEF/2
      - id: flags
        type: attdef_flags
        doc: ATTDEF/70
      - id: rotation_angle_in_radians
        type: f8
        if: entity_common.flag2_7
        doc: ATTDEF/50
      - id: width_scale_factor
        type: f8
        if: entity_common.flag2_6
        doc: ATTDEF/41
      - id: unknown_index
        type: u1
        if: entity_common.flag2_4
      - id: flags2
        type: attdef_flags2
        if: entity_common.flag2_2
        doc: ATTDEF/72
      - id: end_point
        type: point_2d
        if: entity_common.flag2_1
        doc: ATTDEF/11|21
  entity_attrib:
    seq:
      - id: entity_common
        type: entity_common
      - id: u1
        type: f8
        doc: ATTRIB/10
      - id: u2
        type: f8
        doc: ATTRIB/20
      - id: u3
        type: f8
        doc: ATRRIB/40
      - id: size
        type: s2
      - id: text
        size: size
        doc: ATRRIB/1
      - id: size2
        type: s2
      - id: text2
        size: size2
        doc: ATRRIB/2
      - id: u4
        type: u1
      - id: u5
        type: f8
        if: entity_common.flag2_7
        doc: ATRRIB/50
      - id: u6
        type: u1
        if: entity_common.flag2_4
      - id: u7
        type: u1
        if: entity_common.flag2_2
        # 1, 2 nebo 7?
      - id: aligned_to
        type: point_2d
        if: entity_common.flag2_1
        doc: ATTRIB/11|21
  entity_block_begin:
    seq:
      - id: entity_common
        type: entity_common
      - id: x
        type: f8
      - id: y
        type: f8
  entity_block_end:
    seq:
      - id: entity_common
        type: entity_common
  entity_insert:
    seq:
      - id: entity_common
        type: entity_common
      - id: block_index
        type: s2
        doc: INSERT/2
      - id: x
        type: f8
        doc: INSERT/10
      - id: y
        type: f8
        doc: INSERT/20
      - id: x_scale
        type: f8
        if: entity_common.flag2_8
        doc: INSERT/41
      - id: y_scale
        type: f8
        if: entity_common.flag2_7
        doc: INSERT/42
      - id: rotation_angle_in_radians
        type: f8
        if: entity_common.flag2_6
        doc: INSERT/50
      - id: z_scale
        type: f8
        if: entity_common.flag2_5
        doc: INSERT/43
      - id: columns
        type: u2
        if: entity_common.flag2_4
        doc: INSERT/70
      - id: rows
        type: u2
        if: entity_common.flag2_3
        doc: INSERT/71
      - id: column_spacing
        type: f8
        if: entity_common.flag2_2
        doc: INSERT/44
      - id: row_spacing
        type: f8
        if: entity_common.flag2_1
        doc: INSERT/45
  entity_circle:
    seq:
      - id: entity_common
        type: entity_common
      - id: x
        type: f8
        doc: CIRCLE/10
      - id: y
        type: f8
        doc: CIRCLE/20
      - id: radius
        type: f8
        doc: CIRCLE/40
  entity_dim:
    seq:
      - id: entity_common
        type: entity_common
      - id: block_index
        type: s2
      - id: dimension_line_defining_point
        type: point_2d
        doc: DIMENSION/10|20
      - id: default_text_position
        type: point_2d
        doc: DIMENSION/11|21
      - id: unknown1
        type: u1
        if: entity_common.flag2_7
        doc: DIMENSION/70
      - id: text_size
        type: s2
        if: entity_common.flag2_6
      - id: text
        size: text_size
        if: entity_common.flag2_6
        doc: DIMENSION/1
      - id: extension_defining_point1
        type: point_2d
        if: entity_common.flag2_5
        doc: DIMENSION/13|23
      - id: extension_defining_point2
        type: point_2d
        if: entity_common.flag2_4
        doc: DIMENSION/14|24
      - id: defining_point
        type: point_2d
        if: entity_common.flag2_3
        doc: DIMENSION/15|25
      - id: dimension_line_arc_definition_point
        type: point_2d
        if: entity_common.flag2_2
      - id: rotation_in_radians
        type: f8
        if: entity_common.flag3_8
  entity_face3d:
    seq:
      - id: entity_common
        type: entity_common
      - id: first_point_x
        type: f8
      - id: first_point_y
        type: f8
      - id: first_point_z
        type: f8
        if: entity_common.flag2_8
      - id: second_point_x
        type: f8
      - id: second_point_y
        type: f8
      - id: second_point_z
        type: f8
        if: entity_common.flag2_7
      - id: third_point_x
        type: f8
      - id: third_point_y
        type: f8
      - id: third_point_z
        type: f8
        if: entity_common.flag2_6
      - id: fourth_point_x
        type: f8
      - id: fourth_point_y
        type: f8
      - id: fourth_point_z
        type: f8
        if: entity_common.flag2_5
  entity_line:
    seq:
      - id: entity_common
        type: entity_common
      - id: x1
        type: f8
        doc: LINE/10
      - id: y1
        type: f8
        doc: LINE/20
      - id: x2
        type: f8
        doc: LINE/11
      - id: y2
        type: f8
        doc: LINE/21
  entity_line3d:
    seq:
      - id: entity_common
        type: entity_common
      - id: x1
        type: f8
        doc: 3DLINE/10
      - id: y1
        type: f8
        doc: 3DLINE/20
      - id: z1
        type: f8
        if: entity_common.flag2_8
        doc: 3DLINE/30
      - id: x2
        type: f8
        doc: 3DLINE/11
      - id: y2
        type: f8
        doc: 3DLINE/21
      - id: z2
        type: f8
        if: entity_common.flag2_7
        doc: 3DLINE/31
  entity_tmp:
    seq:
      - id: entity_mode
        type: entity_mode
      - id: entity_size
        type: s2
      - id: xxx
        size: entity_size - 4
  entity_point:
    seq:
      - id: entity_common
        type: entity_common
      - id: x
        type: f8
        doc: POINT/10
      - id: y
        type: f8
        doc: POINT/20
  entity_polyline:
    seq:
      - id: entity_common
        type: entity_common
      - id: closed
        type: u1
        if: entity_common.flag2_8
        doc: POLYLINE/66
      - id: x
        type: f8
        if: entity_common.flag2_7
        doc: POLYLINE/40
      - id: y
        type: f8
        if: entity_common.flag2_6
        doc: POLYLINE/41
  entity_seqend:
    seq:
      - id: entity_common
        type: entity_common
      - id: unknown
        size: 4
  entity_shape:
    seq:
      - id: entity_common
        type: entity_common
      - id: x
        type: f8
      - id: y
        type: f8
      - id: height
        type: f8
      - id: item_num
        type: u1
      - id: angle
        type: f8
        if: entity_common.flag2_8
      - id: load_num
        type: u1
  entity_solid:
    seq:
      - id: entity_common
        type: entity_common
      - id: from
        type: point_2d
      - id: from_and
        type: point_2d
      - id: to
        type: point_2d
      - id: to_and
        type: point_2d
  entity_text:
    seq:
      - id: entity_common
        type: entity_common
      - id: x
        type: f8
        doc: TEXT/10
      - id: y
        type: f8
        doc: TEXT/20
      - id: height
        type: f8
        doc: TEXT/40
      - id: size
        type: s2
      - id: value
        size: size
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: TEXT/1
      - id: angle
        type: f8
        if: entity_common.flag2_8
        doc: TEXT/50
      - id: width_factor
        type: f8
        if: entity_common.flag2_7
        doc: TEXT/41
      - id: obliquing_angle
        type: f8
        if: entity_common.flag2_6
        doc: TEXT/51
      - id: style_index
        type: u1
        if: entity_common.flag2_5
        doc: TEXT/7
      - id: generation
        type: generation_flags
        if: entity_common.flag2_4
        doc: TEXT/71
      - id: type
        enum: text_type
        type: u1
        if: entity_common.flag2_3
        doc: TEXT/72
      - id: aligned_to
        type: point_2d
        if: entity_common.flag2_2
        doc: TEXT/11|21
  entity_trace:
    seq:
      - id: entity_common
        type: entity_common
      - id: from
        type: point_2d
      - id: from_and
        type: point_2d
      - id: to
        type: point_2d
      - id: to_and
        type: point_2d
  entity_vertex:
    seq:
      - id: entity_common
        type: entity_common
      - id: x
        type: f8
        doc: VERTEX/10
      - id: y
        type: f8
        doc: VERTEX/20
      - id: width
        type: f8
        if: entity_common.flag2_8
      - id: unknown1
        type: f8
        if: entity_common.flag2_7
      - id: bulge
        type: f8
        if: entity_common.flag2_6
        doc: VERTEX/42
      - id: unknown2
        type: u1
        if: entity_common.flag2_5
      - id: unknown_in_radians
        type: f8
        if: entity_common.flag2_4
        doc: VERTEX/50
  attdef_flags:
    seq:
      - id: flag_1
        type: b1
      - id: flag_2
        type: b1
      - id: flag_3
        type: b1
      - id: flag_4
        type: b1
      - id: flag_5
        type: b1
      - id: invisible
        type: b1
      - id: constant
        type: b1
      - id: verify
        type: b1
  attdef_flags2:
    seq:
## TODO Tohle je divne
      - id: flag_1
        type: b1
      - id: flag_2
        type: b1
      - id: flag_3
        type: b1
      - id: flag_4
        type: b1
      - id: flag_5
        type: b1
      - id: middle
        type: b1
      - id: right
        type: b1
      - id: center
        type: b1
  layer:
    seq:
      - id: flag
        type: layer_flag
        doc: LAYER/70
      - id: layer_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: LAYER/2
      - id: color
        type: s2
        doc: LAYER/62
      - id: linetype_index
        type: u2
        doc: LAYER/6
      - id: u1
        type: s1
  layer_flag:
    seq:
      - id: flag1
        type: b1
      - id: flag2
        type: b1
      - id: flag3
        type: b1
      - id: flag4
        type: b1
      - id: flag5
        type: b1
      - id: flag6
        type: b1
      - id: flag7
        type: b1
      - id: frozen
        type: b1
  linetype:
    seq:
      - id: flag
        type: linetype_flag
        doc: LTYPE/70
      - id: linetype_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: LTYPE/2
      - id: description
        size: 48
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: LTYPE/3
      - id: alignment
        type: u1
        doc: LTYPE/72
      - id: num_dashes
        type: u1
        doc: LTYPE/73
      - id: pattern_len
        type: f8
        doc: LTYPE/40
      - id: pattern
        type: pattern
        doc: LTYPE/49
      - id: u21
        type: s1
  pattern:
    seq:
      - id: pattern1
        type: f8
      - id: pattern2
        type: f8
      - id: pattern3
        type: f8
      - id: pattern4
        type: f8
      - id: pattern5
        type: f8
      - id: pattern6
        type: f8
      - id: pattern7
        type: f8
      - id: pattern8
        type: f8
      - id: pattern9
        type: f8
      - id: pattern10
        type: f8
      - id: pattern11
        type: f8
      - id: pattern12
        type: f8
  linetype_flag:
    seq:
      - id: flag1
        type: b1
      - id: flag2
        type: b1
      - id: flag3
        type: b1
      - id: flag4
        type: b1
      - id: flag5
        type: b1
      - id: flag6
        type: b1
      - id: flag7
        type: b1
      - id: frozen
        type: b1
  real_entities:
    seq:
      - id: entities
        type: entity
        repeat: eos
  style:
    seq:
      - id: flag
        type: style_flag
        doc: STYLE/70
      - id: style_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: STYLE/2
      - id: height
        type: f8
        doc: STYLE/40
      - id: width_factor
        type: f8
        doc: STYLE/41
      - id: obliquing_angle_in_radians
        type: f8
        doc: STYLE/50
      - id: generation
        type: generation_flags
        doc: STYLE/71
      - id: last_height
        type: f8
        doc: STYLE/42
      - id: font_file
        size: 64
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: STYLE/3
      - id: u1
        size: 64
  style_flag:
    seq:
      - id: flag1
        type: b1
      - id: flag2
        type: b1
      - id: flag3
        type: b1
      - id: flag4
        type: b1
      - id: flag5
        type: b1
      - id: vertical
        type: b1
      - id: flag7
        type: b1
      - id: load
        type: b1
  view:
    seq:
      - id: flag
        type: view_flag
        doc: VIEW/70
      - id: view_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
      - id: view_size
        type: f8
        doc: VIEW/40
      - id: center_point
        type: point_2d
        doc: VIEW/10|20
      - id: view_width
        type: f8
        doc: VIEW/41
      - id: view_dir
        type: point_3d
        doc: VIEW/11|21|31
      - id: u3
        type: s2
      - id: u4
        type: u1
  view_flag:
    seq:
      - id: flag1
        type: b1
      - id: flag2
        type: b1
      - id: flag3
        type: b1
      - id: flag4
        type: b1
      - id: flag5
        type: b1
      - id: flag6
        type: b1
      - id: flag7
        type: b1
      - id: flag8
        type: b1
  generation_flags:
    seq:
      - id: flag1
        type: b1
      - id: flag2
        type: b1
      - id: flag3
        type: b1
      - id: flag4
        type: b1
      - id: flag5
        type: b1
      - id: upside_down
        type: b1
      - id: backwards
        type: b1
      - id: flag8
        type: b1
  point_2d:
    seq:
      - id: x
        type: f8
      - id: y
        type: f8
  point_3d:
    seq:
      - id: x
        type: f8
      - id: y
        type: f8
      - id: z
        type: f8
enums:
  entities:
    1: line
    2: point
    3: circle
    4: shape
    # NOT_USED 5: repeat_begin
    # NOT_USED 6: repeat_end
    7: text
    8: arc
    9: trace
    # NOT_USED 10: load
    11: solid
    12: block_begin
    13: block_end
    14: insert
    15: attdef
    16: attrib
    17: seqend
    18: polyline
    19: polyline2
    20: vertex
    21: line3d
    22: face3d
    23: dim
  osnap_modes:
    0: none
    1: endpoint
    2: midpoint
    4: center
    8: node
    16: quadrant
    32: intersection
    64: insertion
    128: perpendicular
    256: tangent
    512: nearest
  unit_types:
    1: scientific
    2: decimal
    3: engineering
    4: architectural
    5: fractional
  units_for_angles:
    0: decimal_degrees
    1: degrees_minutes_seconds
    2: gradians
    3: radians
    4: surveyor_s_units
  angle_direction:
    0: counterclockwise
    1: clockwise
  limits_check:
    0: objects_can_outside_grid
    1: objects_cannot_outside_grid
  coordinates:
    0: absolute_coordinates
    1: absolute_coordinates_realtime
    2: relative_polar_coordinates
  attributes:
    0: off
    1: normal
    2: on
  current_color:
    0: byblock
    1: red
    2: yellow
    3: green
    4: cyan
    5: blue
    6: magenta
    7: white
    256: bylayer
  iso_plane:
    0: left
    1: top
    2: right
  text_type:
    1: center
    2: end
    3: aligned
    4: middle
    5: fit
