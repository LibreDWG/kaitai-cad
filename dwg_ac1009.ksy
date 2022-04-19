meta:
  id: dwg_ac1009
  title: AutoCAD r11 drawing (AC1009)
  application: AutoCAD
  file-extension:
    - dwg
  license: CC0-1.0
  xref:
    justsolve: DWG
    pronom:
      fmt: 32
    mime:
      - application/x-dwg
      - image/vnd.dwg
    wikidata: Q27863127
  endian: le
seq:
  - id: header
    type: header
  - id: entities
    type: real_entities
    size: header.entities_end - header.entities_start
  - id: crc_entities
    size: header.table_block.start-_io.pos
  - id: blocks
    type: block
    repeat: expr
    repeat-expr: header.table_block.numitems
  - id: crc_blocks
    size: header.table_layer.start-_io.pos
  - id: layers
    type: layer
    repeat: expr
    repeat-expr: header.table_layer.numitems
  - id: crc_layers
    size: header.table_style.start-_io.pos
  - id: styles
    type: style
    repeat: expr
    repeat-expr: header.table_style.numitems
  - id: crc_styles
    size: header.table_linetype.start-_io.pos
  - id: linetypes
    type: linetype
    repeat: expr
    repeat-expr: header.table_linetype.numitems
  - id: crc_linetypes
    size: header.table_view.start-_io.pos
  - id: views
    type: view
    repeat: expr
    repeat-expr: header.table_view.numitems
  - id: crc_views
    size: header.variables.table_ucs.start-_io.pos
  - id: ucss
    type: ucs
    repeat: expr
    repeat-expr: header.variables.table_ucs.numitems
  - id: crc_ucss
    size: header.variables.table_vport.start-_io.pos
  - id: vports
    type: vport
    repeat: expr
    repeat-expr: header.variables.table_vport.numitems
  - id: crc_vports
    size: header.variables.table_appid.start-_io.pos
  - id: appids
    type: appid
    repeat: expr
    repeat-expr: header.variables.table_appid.numitems
  - id: crc_appids
    size: header.variables.table_dimstyle.start-_io.pos
  - id: dimstyles
    type: dimstyle
    repeat: expr
    repeat-expr: header.variables.table_dimstyle.numitems
  - id: crc_dimstyles
    size: header.variables.table_vx.start-_io.pos
  - id: vxs
    type: vx
    repeat: expr
    repeat-expr: header.variables.table_vx.numitems
  - id: crc_vxs
    size: header.blocks_start-_io.pos
  - id: block_entities
    type: real_entities
    size: header.blocks_size
  - id: crc_block_entities
    size: 32
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
      - id: block_scaling
        type: s1
      - id: num_owned
        type: s2
      - id: flag2
        type: block_flag2
#      - id: num_inserts
#        type: u1
#      - id: flag3
#        type: block_flag3
      - id: u1
        type: f8
  block_flag:
    seq:
      - id: none
        type: b1
      - id: anonymous_block
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: resolved_external_reference
        type: b1
      - id: references_external_reference
        type: b1
  block_flag2:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: flag2
        type: b1
      - id: flag1
        type: b1
  block_flag3:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: flag2
        type: b1
      - id: flag1
        type: b1
  header:
    seq:
      - id: magic
        contents: AC1009
        # [0x41, 0x43, 0x31, 0x30, 0x30, 0x39]
        doc: 0x0000-0x0005, $ACADVER/1
      - id: zeros
        size: 6
      - id: zero_one_or_three
        type: s1
      - id: unknown_3
        type: s2
        contents: 3
      - id: num_sections
        type: u2
        contents: 5
      - id: num_header_vars
        type: u2
        contents: 129
      - id: dwg_version
        type: u1
        contents: 0
      - id: entities_start
        type: u4
      - id: entities_end
        type: u4
      - id: blocks_start
        type: u4
      - id: blocks_offset
        type: u4
        # contents: 0x40000000
      - id: blocks_end
        type: u4
      - id: blocks_max
        type: u4
        # contents: 0x80000000
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
      #blocks_size_unknown:
      #  value: (blocks_offset & 0xff000000) >> 24
      blocks_size:
        value: (blocks_offset & 0x00ffffff)
  table:
    seq:
      - id: size
        type: u2
      - id: numitems
        type: u2
      - id: flags
        type: u2
      - id: start
        type: u4
  header_variables:
    seq:
      - id: insertion_base
        type: point_3d
        doc: 0x005e-0x0075, $INSBASE/10|20|30
      - id: plinegen
        type: s2
        doc: 0x0076-0x0077, $PLINEGEN/70
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
        doc: 0x00e0-0x00e7, $VIEWSIZE/40
      - id: snap_mode
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
      - id: grid_mode
        type: s2
        doc: 0x0116-0x0117, $GRIDMODE
      - id: grid_unit
        type: point_2d
        doc: 0x0118-0x0127, $GRIDUNIT/10|20
      - id: ortho_mode
        type: s2
        doc: 0x0128-0x0129, $ORTHOMODE
      - id: regen_mode
        type: s2
        doc: 0x012a-0x012b, $REGENMODE
      - id: fill_mode
        type: s2
        doc: 0x012c-0x012d, $FILLMODE
      - id: qtext_mode
        type: s2
        doc: 0x012e-0x012f, $QTEXTMODE
      - id: drag_mode
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
      - id: celayer
        type: s2
        doc: 0x014a-0x014b, $CLAYER
      - id: old_cecolor
        type: f8
        doc: 0x014c-0x0153
      - id: unknown6
        type: u2
        doc: 0x0154-0x0155
      - id: psltscale
        type: u2
        doc: 0x0156-0x0157, $PSLTSCALE/70
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
        doc: 0x0168-0x0169, $AXISMODE/70
      - id: axis_value
        type: point_2d
        doc: 0x016a-0x0179, $AXISUNIT/10|20
      - id: sketch_increment
        type: f8
        doc: 0x017a-0x0181, $SKETCHINC
      - id: fillet_radius
        type: f8
        doc: $FILLETRAD/40
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
      - id: osnap_mode
        enum: osnap_modes
        type: s2
        doc: 0x0190-0x0191, $OSMODE
      - id: att_visibility
        enum: att_visibility
        type: s2
        doc: 0x0192-0x0193, $ATTMODE/70
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
      - id: unknown10a
        type: u1
        doc: 0x01fc
      - id: unknown10b
        type: u1
      - id: unknown10c
        type: u1
      - id: unknown10d
        type: u1
      - id: unknown10e
        type: u1
      - id: unknown10f
        type: u1
      - id: unknown10g
        type: f8
      - id: unknown10h
        type: u1
      - id: unknown10i
        type: u1
      - id: unknown10j
        type: u1
      - id: unknown10k
        type: u1
      - id: unknown10l
        type: u1
      - id: unknown10m
        type: u1
      - id: unknown10n
        type: u1
      - id: unknown10o
        type: u1
      - id: unknown10p
        type: f8
      - id: unknown10q
        type: f8
      - id: unknown10r
        type: u2
      - id: unknown10s
        type: u2
      - id: unknown10t
        type: u1
      - id: unknown10u
        type: u1
      - id: unknown10v
        type: u1
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
        size: 33
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: $DIMBLK
      - id: circle_zoom_percent
        type: s2
        doc: 0x0317-0x0318
      - id: coordinates
        enum: coordinates
        type: s2
        doc: 0x0319-0x031a, $COORDS
      - id: cecolor
        enum: cecolor
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
        type: u2
        doc: 0x0341-0x0342, $FASTZOOM/70
      - id: sketch_type
        type: u2
        doc: 0x0343-0x0344, $SKPOLY
      - id: unknown_date
        type: unknown_date
      - id: angle_base
        type: f8
        doc: 0x0353-0x035a, $ANGBASE/50
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
      - id: dim_linear_measurements_scale_factor
        type: f8
        doc: 0x03cd-0x03d4, $DIMLFAC
      - id: spline_segs
        type: s2
        doc: 0x03d5-0x03d6, $SPLINESEGS
      - id: spline_frame
        type: s2
        doc: 0x03d7-0x03d8, $SPLFRAME
      - id: att_prompting_during_insert
        type: u2
        doc: 0x03d9-0x03da, $ATTREQ/70
      - id: att_entry_dialogs
        type: u2
        doc: 0x03db-0x03dc, $ATTDIA/70
      - id: chamfera
        type: f8
        doc: 0x03dd-0x04e4, $CHAMFERA/40
      - id: chamferb
        type: f8
        doc: 0x04e5-0x04ec, $CHAMFERB/40
      - id: mirror_text
        type: s2
        doc: 0x03ed-0x03ee, $MIRRTEXT
      - id: table_ucs
        type: table
      - id: unknown37
        size: 2
      - id: ucs_origin_point
        type: point_3d
        doc: $UCSORG/10|20|30
      - id: ucs_x_dir
        type: point_3d
        doc: $UCSXDIR/11|21|31 ~ $UCSXORI
      - id: ucs_y_dir
        type: point_3d
        doc: $UCSYDIR/12|22|32 ~ $UCSYORI
      - id: target
        type: point_3d
        doc: $TARGET
      - id: lens_length
        type: f8
        doc: $LENSLENGTH
      - id: view_rotation_angle_radians
        type: f8
        doc: $VIEWTWIST
      - id: frontz_z
        type: f8
        doc: $FRONTZ
      - id: backz_z
        type: f8
        doc: $BACKZ
      - id: view_mode
        type: u2
        doc: $VIEWMODE
      - id: dim_tofl
        type: u1
        doc: 0x047d, $DIMTOFL
      - id: dim_arrowhead_block1
        size: 33
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: $DIMBLK1
      - id: dim_arrowhead_block2
        size: 33
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: $DIMBLK2
      - id: dim_arrowhead_blocks_control
        type: u1
        doc: $DIMSAH
      - id: dim_text_between_ext_lines
        type: u1
        doc: $DIMTIX
      - id: dim_arrowhead_suppress
        type: u1
        doc: $DIMSOXD
      - id: dim_text_vertical_position_size
        type: f8
        doc: $DIMTVP
      - id: unknown_string
        size: 33
        type: str
        encoding: ASCII
        terminator: 0x00
      - id: handling
        type: u2
        doc: $HANDLING
      - id: handseed
        type: u8be
        doc: $HANDSEED, in hex
      - id: surfu
        type: u2
        doc: $SURFU
      - id: surfv
        type: u2
        doc: $SURFV
      - id: surftype
        type: u2
        doc: $SURFTYPE
      - id: surftab1
        type: u2
        doc: $SURFTAB1
      - id: surftab2
        type: u2
        doc: $SURFTAB2
      - id: table_vport
        type: table
      - id: flatland
        type: u2
        doc: 0x050a-0x050b, $FLATLAND
      - id: spline_type
        type: u2
        enum: spline_type
        doc: 0x050c-0x050d, $SPLINETYPE
      - id: ucs_icon
        type: u2
        doc: $UCSICON
      - id: unknown47
        type: u2
      - id: table_appid
        type: table
        doc: 0x0512-0x051c
      - id: world_view
        type: u2
        doc: 0x051d-0x051e, $WORLDVIEW/70
      - id: unknown49a
        type: u2
      - id: unknown49b
        type: u2
      - id: table_dimstyle
        type: table
      - id: unknown49c
        size: 5
      - id: dim_line_color
        type: u2
        doc: $DIMCLRD_C/70
      - id: dim_clre_c
        type: u2
        doc: $DIMCLRE_C/70
      - id: dim_clrt_c
        type: u2
        doc: $DIMCLRT_C/70
      - id: shade_edge
        type: u2
        doc: $SHADEDGE/70
      - id: shade_dif
        type: u2
        doc: $SHADEDIF/70
      - id: unit_mode
        type: u2
        doc: $UNITMODE/70
      - id: unknown50
        size: 10
      - id: unknown51
        type: f8
      - id: unknown52
        type: f8
      - id: unknown53
        type: f8
      - id: unknown_unit1
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
      - id: unknown_unit2
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
      - id: unknown_unit3
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
      - id: unknown_unit4
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
      - id: dim_tfac
        type: f8
        doc: $DIMTFAC/40
      - id: p_ucs_org
        type: point_3d
        doc: $PUCSORG/10
      - id: p_ucs_xdir
        type: point_3d
        doc: $PUCSXDIR/11
      - id: p_ucs_ydir
        type: point_3d
        doc: $PUCSXDIR/12
      - id: unknown55
        type: u2
      - id: tile_mode
        type: u1
        doc: $TILEMODE/70
      - id: plim_check
        type: u2
        doc: $PLIMCHECK/70
      - id: unknown56
        type: u2
      - id: unknown57
        type: u1
      - id: p_ext_min
        type: point_3d
        doc: $PEXTMIN/10
      - id: p_ext_max
        type: point_3d
        doc: $PEXTMAX/10
      - id: p_lim_min
        type: point_2d
        doc: $PLIMMIN/10
      - id: p_lim_max
        type: point_2d
        doc: $PLIMMAX/10
      - id: p_insertion_base
        type: point_3d
        doc: $PINSBASE/10|20|30
      - id: table_vx
        type: table
        doc: 0x069f-0x06a8
      - id: max_actvp
        type: u2
        doc: $MAXACTVP/70
      - id: dim_gap
        type: f8
        doc: $DIMGAP/40
      - id: p_elevation
        type: f8
        doc: $PELEVATION/40
      - id: vis_retain
        type: u2
        doc: $VISRETAIN/70
      - id: unknown59
        size: 18
        doc: 7ef
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
  unknown_date:
    seq:
      - id: month
        type: u2
      - id: day
        type: u2
      - id: year
        type: u2
      - id: hour
        type: u2
      - id: minute
        type: u2
      - id: second
        type: u2
      - id: ms
        type: u2
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
            'entities::block_begin': entity_block_begin
            'entities::block_end': entity_block_end
            'entities::insert': entity_insert
            'entities::circle': entity_circle
            'entities::dim': entity_dim
            'entities::face3d': entity_face3d
            'entities::line': entity_line
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
      - id: entity_xdata
        type: b1
      - id: entity_xref_resolved
        type: b1
      - id: entity_xref_ref
        type: b1
      - id: entity_xref_dep
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
      - id: opt2_128
        type: b1
      - id: opt2_64
        type: b1
      - id: opt2_32
        type: b1
      - id: opt2_16
        type: b1
      - id: opt2_8
        type: b1
      - id: opt2_4
        type: b1
      - id: opt2_2
        type: b1
      - id: opt2_1
        type: b1
      - id: opt3_128
        type: b1
      - id: opt3_64
        type: b1
      - id: opt3_32
        type: b1
      - id: opt3_16
        type: b1
      - id: opt3_8
        type: b1
      - id: opt3_4
        type: b1
      - id: opt3_2
        type: b1
      - id: opt3_1
        type: b1
      - id: entity_color
        type: s1
        if: entity_mode.entity_color_flag
      - id: entity_linetype_index
        type: s1
        if: entity_mode.entity_linetype_flag
      - id: entity_thickness
        type: f8
        if: entity_mode.entity_thickness_flag
      - id: xdata_size
        type: u1
        if: entity_mode.entity_xdata
      - id: xdata
        size: xdata_size
        if: entity_mode.entity_xdata
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
        doc: ATTDEF/1
      - id: prompt_size
        type: s2
      - id: prompt
        size: prompt_size
        doc: ATTDEF/3
      - id: tag_size
        type: s2
      - id: tag
        size: tag_size
        doc: ATTDEF/2
      - id: flags
        type: attdef_flags
        doc: ATTDEF/70
      - id: rotation_angle_in_radians
        type: f8
        if: entity_common.opt2_2
        doc: ATTDEF/50
      - id: width_scale_factor
        type: f8
        if: entity_common.opt2_4
        doc: ATTDEF/41
      - id: generation
        type: u1
        if: entity_common.opt2_16
      - id: horiz_alignment
        type: u1
        if: entity_common.opt2_64
        doc: ATTDEF/72
      - id: alignment_point
        type: point_2d
        if: entity_common.opt2_128
        doc: ATTDEF/11|21
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
        if: entity_common.opt2_1
        doc: INSERT/41
      - id: y_scale
        type: f8
        if: entity_common.opt2_2
        doc: INSERT/42
      - id: rotation_angle_in_radians
        type: f8
        if: entity_common.opt2_4
        doc: INSERT/50
      - id: z_scale
        type: f8
        if: entity_common.opt2_8
        doc: INSERT/43
      - id: columns
        type: u2
        if: entity_common.opt2_16
        doc: INSERT/70
      - id: rows
        type: u2
        if: entity_common.opt2_32
        doc: INSERT/71
      - id: column_spacing
        type: f8
        if: entity_common.opt2_64
        doc: INSERT/44
      - id: row_spacing
        type: f8
        if: entity_common.opt2_128
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
      - id: dimension_line_defining_point_z
        type: f8
        if: entity_common.entity_mode.entity_elevation_flag == false
        doc: DIMENSION/30
      - id: default_text_position
        type: point_2d
        doc: DIMENSION/11|21
      #- id: default_text_position_z
      #  type: f8
      #  if: entity_common.entity_mode.entity_elevation_flag == false
      #  doc: DIMENSION/31
      - id: unknown1
        type: u1
        if: entity_common.opt2_2
        doc: DIMENSION/70
      - id: text_size
        type: s2
        if: entity_common.opt2_4
      - id: text
        size: text_size
        if: entity_common.opt2_4
        doc: DIMENSION/1
      - id: extension_defining_point1
        type: point_2d
        if: entity_common.opt2_8
        doc: DIMENSION/13|23
      - id: extension_defining_point1_z
        type: f8
        if: |
          entity_common.entity_mode.entity_elevation_flag == false
          and entity_common.opt2_8
        doc: DIMENSION/33
      - id: extension_defining_point2
        type: point_2d
        if: entity_common.opt2_16
        doc: DIMENSION/14|24
      - id: extension_defining_point2_z
        type: f8
        if: |
          entity_common.entity_mode.entity_elevation_flag == false
          and entity_common.opt2_16
        doc: DIMENSION/34
      - id: defining_point
        type: point_2d
        if: entity_common.opt2_32
        doc: DIMENSION/15|25
      - id: defining_point_z
        type: f8
        if: |
          entity_common.entity_mode.entity_elevation_flag == false
          and entity_common.opt2_32
        doc: DIMENSION/35
      - id: dimension_line_arc_definition_point
        type: point_2d
        if: entity_common.opt2_64
      - id: dimension_line_arc_definition_point_z
        type: f8
        if: |
          entity_common.entity_mode.entity_elevation_flag == false
          and entity_common.opt2_64
      - id: unknown2
        type: point_2d
        if: entity_common.opt2_128
      - id: unknown2_z
        type: f8
        if: |
          entity_common.entity_mode.entity_elevation_flag == false
          and entity_common.opt2_128
      - id: rotation_in_radians
        type: f8
        if: entity_common.opt3_1
  entity_face3d:
    seq:
      - id: entity_common
        type: entity_common
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
      - id: z1
        type: f8
        if: entity_common.entity_mode.entity_elevation_flag == false
        doc: LINE/30
      - id: x2
        type: f8
        doc: LINE/11
      - id: y2
        type: f8
        doc: LINE/21
      - id: z2
        type: f8
        if: entity_common.entity_mode.entity_elevation_flag == false
        doc: LINE/31
  entity_tmp:
    seq:
      - id: entity_mode
        type: entity_mode
      - id: entity_size
        type: s2
      - id: entity_layer_index
        type: s1
      - id: flag1
        type: s1
      - id: opt2_128
        type: b1
      - id: opt2_64
        type: b1
      - id: opt2_32
        type: b1
      - id: opt2_16
        type: b1
      - id: opt2_8
        type: b1
      - id: opt2_4
        type: b1
      - id: opt2_2
        type: b1
      - id: opt2_1
        type: b1
      - id: opt3_128
        type: b1
      - id: opt3_64
        type: b1
      - id: opt3_32
        type: b1
      - id: opt3_16
        type: b1
      - id: opt3_8
        type: b1
      - id: opt3_4
        type: b1
      - id: opt3_2
        type: b1
      - id: opt3_1
        type: b1
      - id: xxx
        size: entity_size - 8
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
        if: entity_common.opt2_1
        doc: POLYLINE/66
      - id: x
        type: f8
        if: entity_common.opt2_2
        doc: POLYLINE/40
      - id: y
        type: f8
        if: entity_common.opt2_4
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
        doc: SHAPE/10
      - id: y
        type: f8
        doc: SHAPE/20
      - id: height
        type: f8
        doc: SHAPE/40
      - id: item_num
        type: u1
        doc: SHAPE/2
      - id: angle_in_radians
        type: f8
        if: entity_common.opt2_1
        doc: SHAPE/50
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
      - id: y
        type: f8
      - id: height
        type: f8
      - id: size
        type: s2
      - id: value
        size: size
      - id: angle
        type: f8
        if: entity_common.opt2_1
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
        if: entity_common.opt2_1
      - id: bulge
        type: f8
        if: entity_common.opt2_4
        doc: VERTEX/42
      - id: unknown_in_radians
        type: f8
        if: entity_common.opt2_16
        doc: VERTEX/50
  attdef_flags:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: invisible
        type: b1
      - id: constant
        type: b1
      - id: verify
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
      - id: unknown3
        type: s1
      - id: unknown4
        type: s1
      - id: unknown5
        type: u2
  layer_flag:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: flag2
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
      - id: unknown
        type: s1
      - id: unknown2
        size: 27
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
  linetype_flag:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: flag2
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
      - id: bigfont_file
        size: 64
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: STYLE/4
      - id: unknown
        size: 4
  style_flag:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: vertical
        type: b1
      - id: flag2
        type: b1
      - id: load
        type: b1
  view:
    seq:
      - id: u1
        size: 4
      - id: view_name
        size: 31
        type: str
        encoding: ASCII
        terminator: 0x2e
      - id: u2
        type: u1
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
        size: 58
  ucs:
    seq:
      - id: flag
        type: ucs_flag
        doc: UCS/70
      - id: ucs_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: UCS/2
      - id: ucs_org
        type: point_3d
        doc: UCS/10|20|30
      - id: ucs_x_dir
        type: point_3d
        doc: UCS/11|21|31
      - id: ucs_y_dir
        type: point_3d
        doc: UCS/12|22|32
  ucs_flag:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: flag2
        type: b1
      - id: flag1
        type: b1
  vport:
    seq:
      - id: flag
        type: vport_flag
        doc: VPORT/70
      - id: vport_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: VPORT/2
      - id: view_size_vport_10_20
        type: point_2d
        doc: VPORT/10|20, TODO
      - id: view_ctrl_vport_11_21
        type: point_2d
        doc: VPORT/11|21
      - id: view_taget_vport_17_27_37
        type: point_3d
        doc: VPORT/17|27|37
      - id: vport_16_26_36
        type: point_3d
        doc: VPORT/16|26|36
      - id: vport_51_in_radians
        type: f8
        doc: VPORT/51
      - id: vport_40
        type: f8
        doc: VPORT/40
      - id: vport_12_22
        type: point_2d
        doc: VPORT/12|22
      - id: vport_41
        type: f8
        doc: VPORT/41
      - id: vport_42
        type: f8
        doc: VPORT/42
      - id: vport_43
        type: f8
        doc: VPORT/43
      - id: vport_44
        type: f8
        doc: VPORT/44
      - id: vport_71
        type: u2
        doc: VPORT/71
      - id: vport_72
        type: u2
        doc: VPORT/72
      - id: vport_73
        type: u2
        doc: VPORT/73
      - id: vport_74
        type: u2
        doc: VPORT/74
      - id: vport_75
        type: u2
        doc: VPORT/75
      - id: vport_76
        type: u2
        doc: VPORT/76
      - id: vport_77
        type: u2
        doc: VPORT/77
      - id: vport_78
        type: u2
        doc: VPORT/78
      - id: u14
        type: f8
      - id: u15
        type: f8
      - id: u16
        type: f8
      - id: vport_14_24
        type: point_2d
        doc: VPORT/14|24
      - id: vport_15_25
        type: point_2d
        doc: VPORT/15|25
      - id: u17
        size: 4
  vport_flag:
    seq:
      - id: deleted
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: flag2
        type: b1
      - id: flag1
        type: b1
  appid:
    seq:
      - id: flag
        type: appid_flag
        doc: APPID/70
      - id: appid_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: APPID/2
      - id: u1
        size: 4
  appid_flag:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: flag2
        type: b1
      - id: flag1
        type: b1
  dimstyle:
    seq:
      - id: flag
        type: dimstyle_flag
        doc: DIMSTYLE/70
      - id: dimstyle_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: DIMSTYLE/2
      - id: u1
        size: 291
  dimstyle_flag:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: flag2
        type: b1
      - id: flag1
        type: b1
  vx:
    seq:
      - id: flag
        type: vx_flag
        doc: APPID/70
      - id: vx_name
        size: 32
        type: str
        encoding: ASCII
        terminator: 0x00
        doc: VX/2
      - id: u1
        size: 4
  vx_flag:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: flag4
        type: b1
      - id: flag2
        type: b1
      - id: flag1
        type: b1
  generation_flags:
    seq:
      - id: flag128
        type: b1
      - id: flag64
        type: b1
      - id: flag32
        type: b1
      - id: flag16
        type: b1
      - id: flag8
        type: b1
      - id: upside_down
        type: b1
      - id: backwards
        type: b1
      - id: flag1
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
    # 16 TODO attrib
    17: seqend
    18: polyline
    19: polyline2
    20: vertex
    # NOT_USED 21: line3d
    22: face3d
    23: dim
    # TODO 24: viewport
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
  att_visibility:
    0: off
    1: normal
    2: all
  cecolor:
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
  spline_type:
    5: quadratic_b_spline
    6: cubic_b_spline
