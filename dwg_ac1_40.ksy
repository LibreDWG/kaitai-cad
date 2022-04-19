meta:
  id: dwg_ac1_40
  title: AutoCAD r1.40 drawing (AC1.40)
  application: AutoCAD
  file-extension:
    - dwg
  license: CC0-1.0
  xref:
    justsolve: DWG
    pronom:
      fmt: 24
    mime:
      - application/x-dwg
      - image/vnd.dwg
    wikidata: Q27863111
  endian: le
seq:
  - id: header
    type: header
  - id: entities
    type: entity
    repeat: expr
    repeat-expr: header.num_entities
  # 13c layers? [43 5c 5e 02 00 63 2b 00 00 00 00 00 00]
types:
  header:
    seq:
      - id: magic
        contents: AC1.40
        # [0x41, 0x43, 0x31, 0x2e, 0x34, 0x30]
        doc: 0x0000-0x0005, $ACADVER "AC1.40"
      - id: zeros
        size: 6
      - id: insertion_base
        type: point_3d
        doc: 0x000c-0x0023; $INSBASE/10|20|30
      - id: num_bytes
        type: s4
        doc: address after entities
      - id: num_entities
        type: s2
        doc: 0x0028-0x0029
      - id: extmin
        type: point_3d
        doc: 0x0078-0x008f, $EXTMIN/10|20|30
      - id: extmax
        type: point_3d
        doc: 0x0090-0x00a7, $EXTMAX/10|20|30
      - id: limits_min
        type: point_2d
        doc: 0x005a-0x0069, $LIMMIN/10|20
      - id: limits_max
        type: point_2d
        doc: 0x006a-0x0079, $LIMMAX/10|20
      - id: view_ctrl
        type: point_3d
        doc: 0x0080-0x0098, $VIEWCTRL/10|20|30
      - id: view_size
        type: f8
        doc: $VIEWSIZE/40
      - id: snap_mode
        type: s2
        doc: 0x009a-0x009b: $SNAPMODE/70
      - id: snap_resolution
        type: f8
        doc: 0x009c-0x00a3, $SNAPUNIT/10|20
      - id: grid_mode
        type: s2
        doc: 0x00a4-0x00a5, $SNAPBASE/10|20
      - id: grid_unit
        type: f8
        doc: 0x00a6-0x00ad, $GRIDUNIT/10|20
      - id: ortho_mode
        type: s2
        doc: 0x00ae-0x00af, $ORTHOMODE
      - id: regen_mode
        type: s2
        doc: 0x00b0-0x00b1, $REGENMODE
      - id: fill_mode
        type: s2
        doc: 0x00b2-0x00b3, $FILLMODE
      - id: text_size
        type: f8
        doc: $TEXTSIZE
      - id: trace_width
        type: f8
        doc: $TRACEWID
      - id: current_layer
        type: s2
        doc: 0x00c4-0x00c5
      - id: cecolor
        type: s2
        doc: 0x00c6-0x00c7
      - id: layers
        type: s2
        repeat: expr
        repeat-expr: 128
        doc: 0x00c8-0x01c7
      - id: dim_arrowsize
        type: f8
        doc: 0x01c8-0x01cf
      - id: unknown1
        type: f8
        doc: 0x01d0-0x01d7
      - id: linear_units_format
        type: s2
        enum: unit_types
        doc: 0x01d8-0x01d9, $LUNITS
      - id: linear_units_precision
        type: s2
        doc: 0x01da-0x01db, $LUPREC
      - id: dim_text_within_dimension
        type: s2
        doc: 0x01dc-0x01dd
      - id: dim_text_outside_of_dimension
        type: s2
        doc: 0x01de-0x01df
      - id: axis_mode
        type: s2
        doc: 0x01e0-0x01e1
      - id: axis_value
        type: point_2d
        doc: 0x01e2-0x01f1
      - id: sketch_increment
        type: f8
        doc: 0x01f2-0x01f9, Default value is 0.1
      - id: fillet_radius
        type: f8
        doc: 0x01fa-0x0202
  entity:
    seq:
      - id: entity_type
        type: s2
        enum: entities
      - id: data
        type:
          switch-on: entity_type
          cases:
            'entities::arc': entity_arc
            'entities::block_begin': entity_block_begin
            'entities::block_end': entity_block_end
            'entities::block_insert' : entity_block_insert
            'entities::circle': entity_circle
            'entities::line': entity_line
            'entities::load': entity_load
            'entities::point': entity_point
            'entities::repeat_begin': entity_repeat_begin
            'entities::repeat_end': entity_repeat_end
            'entities::shape': entity_shape
            'entities::solid': entity_solid
            'entities::text': entity_text
            'entities::trace': entity_trace
            'entities::tmp_arc': entity_arc
            'entities::tmp_block_insert' : entity_block_insert
            'entities::tmp_circle': entity_circle
            'entities::tmp_line': entity_line
            'entities::tmp_point': entity_point
            'entities::tmp_shape': entity_shape
            'entities::tmp_solid': entity_solid
            'entities::tmp_text': entity_text
            'entities::tmp_trace': entity_trace
  entity_arc:
    seq:
      - id: layer
        type: s2
      - id: x
        type: f8
      - id: y
        type: f8
      - id: radius
        type: f8
      - id: angle_from
        type: f8
      - id: angle_to
        type: f8
  entity_block_begin:
    seq:
      - id: layer
        type: s2
      - id: size
        type: s2
      - id: value
        size: size
      - id: x
        type: f8
      - id: y
        type: f8
  entity_block_end:
    seq:
      - id: layer
        type: s2
  entity_block_insert:
    seq:
      - id: layer
        type: s2
      - id: size
        type: s2
      - id: name
        type: str
        size: size
        encoding: ASCII
      - id: x
        type: f8
      - id: y
        type: f8
      - id: x_scale
        type: f8
      - id: y_scale
        type: f8
      - id: rotation_angle
        type: f8
  entity_circle:
    seq:
      - id: layer
        type: s2
      - id: x
        type: f8
      - id: y
        type: f8
      - id: radius
        type: f8
  entity_line:
    seq:
      - id: layer
        type: s2
      - id: x1
        type: f8
      - id: y1
        type: f8
      - id: x2
        type: f8
      - id: y2
        type: f8
  entity_load:
    seq:
      - id: layer
        type: s2
      - id: size
        type: s2
      - id: value
        size: size
  entity_point:
    seq:
      - id: layer
        type: s2
      - id: x
        type: f8
      - id: y
        type: f8
  entity_repeat_begin:
    seq:
      - id: layer
        type: s2
  entity_repeat_end:
    seq:
      - id: layer
        type: s2
      - id: columns
        type: s2
      - id: rows
        type: s2
      - id: column_distance
        type: f8
      - id: row_distance
        type: f8
  entity_shape:
    seq:
      - id: layer
        type: s2
      - id: x
        type: f8
      - id: y
        type: f8
      - id: height
        type: f8
      - id: angle
        type: f8
      - id: item_num
        type: s2
  entity_solid:
    seq:
      - id: layer
        type: s2
      - id: from_x
        type: f8
      - id: from_y
        type: f8
      - id: from_and_x
        type: f8
      - id: from_and_y
        type: f8
      - id: to_x
        type: f8
      - id: to_y
        type: f8
      - id: to_and_x
        type: f8
      - id: to_and_y
        type: f8
  entity_text:
    seq:
      - id: layer
        type: s2
      - id: x
        type: f8
      - id: y
        type: f8
      - id: height
        type: f8
      - id: angle
        type: f8
      - id: size
        type: s2
      - id: value
        size: size
  entity_trace:
    seq:
      - id: layer
        type: s2
      - id: from_x
        type: f8
      - id: from_y
        type: f8
      - id: from_and_x
        type: f8
      - id: from_and_y
        type: f8
      - id: to_x
        type: f8
      - id: to_y
        type: f8
      - id: to_and_x
        type: f8
      - id: to_and_y
        type: f8
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
    -1: tmp_line
    -2: tmp_point
    -3: tmp_circle
    -4: tmp_shape
    -7: tmp_text
    -8: tmp_arc
    -9: tmp_trace
    -11: tmp_solid
    -14: tmp_block_insert
    1: line
    2: point
    3: circle
    4: shape
    5: repeat_begin
    6: repeat_end
    7: text
    8: arc
    9: trace
    10: load
    11: solid
    12: block_begin
    13: block_end
    14: block_insert
  unit_types:
    1: scientific
    2: decimal
    3: engineering
    4: architectural
