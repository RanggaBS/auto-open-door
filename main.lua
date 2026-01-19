--[[ 
Bully - Auto Open Door mod
Author: RBS ID

YouTube: youtube.com/@rbsid
GitHub: github.com/RanggaBS
Portfolio/personal site: ranggabs.vercel.app
]]

-- -------------------------------------------------------------------------- --
-- Entry Point                                                                --
-- -------------------------------------------------------------------------- --

function main()
  while not SystemIsReady() do
    Wait(0)
  end

  -- Constants
  local DOOR_KEYS = GetAllDoors()

  -- Configs
  local RADIUS = 1.0

  -- Runtime variables
  local px, py, pz = 0.0, 0.0, 0.0

  while true do
    px, py, pz = PlayerGetPosXYZ()

    for _, DOOR_KEY in ipairs(DOOR_KEYS) do
      if IsTriggerLoaded(DOOR_KEY) then
        HandleDoor(GetTriggerValue(DOOR_KEY), px, py, pz, RADIUS)
      end
    end

    if gDerpyScriptLoader and IsKeyBeingPressed('R') then
      DrawTextInline('[R] tapped', 0.1, 1)
    end

    Wait(0)
  end
end

---@param doorTrigger integer
---@param px number
---@param py number
---@param pz number
---@param radius number
function HandleDoor(doorTrigger, px, py, pz, radius)
  local x, y, z = GetAnchorPosition(doorTrigger)
  local inRadius = DistanceBetweenCoords3d(px, py, pz, x, y, z) <= radius
  local isOpen = AreaIsDoorOpen(doorTrigger) or PAnimIsOpen(doorTrigger)
  local isAnimating = IsDoorAnimating(doorTrigger)
  local pedNearby = AnyPedNearbyDoor(x, y, z, radius * 2.0)

  if inRadius then
    if not isOpen and not isAnimating then OpenDoor(doorTrigger, true) end
  else
    if isOpen and not isAnimating and not pedNearby then
      OpenDoor(doorTrigger, false)
    end
  end
end

---@param doorTrigger integer
---@param open boolean
function OpenDoor(doorTrigger, open)
  if not PAnimExists(doorTrigger) then PAnimCreate(doorTrigger) end
  (open and PAnimOpenDoor or PAnimCloseDoor)(doorTrigger)
end

-- -------------------------------------------------------------------------- --
-- Utils                                                                      --
-- -------------------------------------------------------------------------- --

---@param triggerKey string
---@return boolean
function IsTriggerLoaded(triggerKey)
  return _G.TRIGGER[triggerKey] ~= -1
end

---@param triggerKey string
---@return integer|-1
function GetTriggerValue(triggerKey)
  return _G.TRIGGER[triggerKey]
end

---@param triggerValue integer
function IsDoorAnimating(triggerValue)
  return PAnimIsPlayingNode(triggerValue, 'Opening')
    or PAnimIsPlayingNode(triggerValue, 'Closing')
end

---@param dx number
---@param dy number
---@param dz number
---@param radius number
---@return boolean
function AnyPedNearbyDoor(dx, dy, dz, radius)
  local px, py, pz = 0.0, 0.0, 0.0
  for _, ped in { PedFindInAreaXYZ(0, 0, 0, 9999) } do
    if PedIsValid(ped) and ped ~= gPlayer then
      px, py, pz = PedGetPosXYZ(ped)
      if DistanceBetweenCoords3d(dx, dy, dz, px, py, pz) <= radius then
        return true
      end
    end
  end
  return false
end

-- -------------------------------------------------------------------------- --
-- Doors                                                                      --
-- -------------------------------------------------------------------------- --

---@return string[]
function GetAllDoors()
  return {
    '_1_03_barelLad',
    '_1_07_Gate_T',
    '_3_05_3NortonsDoor',
    '_4_02_ObsDoor',
    '_4_03_Bar_05_01',
    '_4_03_Bar_05_02',
    '_4_03_ObsDoor',
    '_5_04_GYMHOOP',
    '_5_04_GYMWALL',
    '_ASYLUM_FRONT_DOOR_R',
    '_ASYLUM_FRONT_GATE_DOOR',
    '_AniBroom',
    '_AsyBars',
    '_AsyBars01',
    '_AsyBars02',
    '_AsyDoorB',
    '_AsyDoors',
    '_AsyDoors10',
    '_AsyDoors11',
    '_AsyDoors12',
    '_AsyDoors13',
    '_AsyDoors14',
    '_AsyDoors15',
    '_BA_DoorStr01',
    '_BA_DoorStr02',
    '_BA_DoorStr03',
    '_BA_DoorStr04',
    '_BA_DoorStr05',
    '_BA_DoorStr07',
    '_BA_DoorStr08',
    '_BA_PrepDoor02',
    '_BA_PrepDoor03',
    '_BA_PrepDoor04',
    '_BA_PrepDoor05',
    '_BA_PrepDoor06',
    '_BA_PrepDoor09',
    '_BA_PrepDoor10',
    '_BA_PrepDoor11',
    '_BBChair',
    '_BBatter',
    '_BCatcher',
    '_BMXGate',
    '_BNews',
    '_BSign',
    '_BTable',
    '_BUmpire',
    '_BXPBag',
    '_BXPBag01',
    '_BXPBag02',
    '_BdrDoorDownstairs1',
    '_BdrDoorDownstairs2',
    '_BdrDoorDownstairs4',
    '_BdrDoorDownstairs5',
    '_BdrDoorDownstairs6',
    '_BdrDoorDownstairs7',
    '_BdrDoorDownstairs8',
    '_BdrDoorL',
    '_BdrDoorL',
    '_BdrDoorL01',
    '_BdrDoorL01',
    '_BdrDoorL02',
    '_BdrDoorL02',
    '_BenchA',
    '_BenchB',
    '_BenchC',
    '_BoxRopes',
    '_BusDoors',
    '_CellDoor',
    '_CellDoor12',
    '_CellDoor13',
    '_CellDoor14',
    '_CellDoor15',
    '_CellDoor16',
    '_CellDoor17',
    '_CellDoor18',
    '_CellDoor19',
    '_CellDoor20',
    '_CellDoor21',
    '_ChezLouis',
    '_Coaster',
    '_CrateBrk',
    '_DRBrace',
    '_DRBrace01',
    '_DRPDoor',
    '_DRPDoor01',
    '_DT_ASYLUM_EXITL',
    '_DT_ASYLUM_SIDE_EXIT',
    '_DT_DormExitDoorL',
    '_DT_FreakEntrance',
    '_DT_FreakExit',
    '_DT_FunhouseTheaterCarnival',
    '_DT_ISCHOOL_BIO',
    '_DT_ISCHOOL_CHEM',
    '_DT_LibraryExitR',
    '_DT_Observatory',
    '_DT_TINDUST_CHEMEX_DOOR',
    '_DT_iSafeDrop_DoorL',
    '_DT_iSafeGrsr_DoorL',
    '_DT_iSafeJock_DoorL',
    '_DT_iSafeNerd_DoorL',
    '_DT_iSafePrep_DoorL',
    '_DT_ibkshop_Door',
    '_DT_iclothp_doorL',
    '_DT_iclothr_DoorL',
    '_DT_icomshp_Basement',
    '_DT_icomshp_Door',
    '_DT_ifunhous_FMDoor',
    '_DT_igrocery_Door',
    '_DT_indoor_TattooShop',
    '_DT_indoor_whouseFront',
    '_DT_indoor_whouseRoof',
    '_DT_ischool_Art',
    '_DT_ischool_AuditorBalc',
    '_DT_ischool_AuditorDoorL',
    '_DT_ischool_BackDoorLeft',
    '_DT_ischool_BackDoorRight',
    '_DT_ischool_Classroom',
    '_DT_ischool_Door01',
    '_DT_ischool_FrontDoorL',
    '_DT_ischool_FrontDoorRight',
    '_DT_ischool_HallWind',
    '_DT_ischool_Janitor',
    '_DT_ischool_RoofDoor',
    '_DT_ischool_Staff',
    '_DT_observatory_doorL',
    '_DT_tBMX_enter',
    '_DT_tBMX_leave',
    '_DT_tbusines_BikeShopDoor',
    '_DT_tbusines_ClothDoor',
    '_DT_tbusines_ComicShopDoor',
    '_DT_tbusines_FirewShopDoor',
    '_DT_tbusines_GenShop1Door',
    '_DT_tbusines_GenShop2Door',
    '_DT_tbusines_SafeNerd',
    '_DT_tbusiness_FirewBusDoor',
    '_DT_tbusiness_Recorddoor',
    '_DT_tbusiness_barber',
    '_DT_tind_SafeDrop',
    '_DT_tpoor_BMX',
    '_DT_tpoor_SafeGreaser',
    '_DT_tpoor_tenwindow',
    '_DT_trich_BarberDoor',
    '_DT_trich_BikeShopDoor',
    '_DT_trich_BoxingDoor02',
    '_DT_trich_ClothRichDoor',
    '_DT_trich_FirewShopDoor',
    '_DT_trich_GenShopDoor',
    '_DT_trich_SafePrep',
    '_DT_tschool_AutoShopL',
    '_DT_tschool_BoysDormL',
    '_DT_tschool_ExtWind',
    '_DT_tschool_GirlsDormL',
    '_DT_tschool_GirlsDormSideL',
    '_DT_tschool_GymL',
    '_DT_tschool_LibraryL',
    '_DT_tschool_PoolL',
    '_DT_tschool_PreppyL',
    '_DT_tschool_RoofDoor',
    '_DT_tschool_SafeJock',
    '_DT_tschool_SchoolFrontDoorL',
    '_DT_tschool_SchoolLeftBackDoor',
    '_DT_tschool_SchoolRightBackDoor',
    '_DT_tschool_SchoolRightFrontDoor',
    '_DT_tschool_SchoolSideDoorL',
    '_Door_PrepHouse_Foyer',
    '_Door_PrepHouse_FoyerOut',
    '_Door_PrepHouse_Gamble',
    '_Door_PrepHouse_Lounge',
    '_Door_PrepHouse_Lounge_02',
    '_Door_PrepHouse_Stairs',
    '_Door_PrepHouse_Stairs_Lower',
    '_Door_PrepHouse_Stairs_Upper',
    '_DormExitDoorR',
    '_DunkBttn',
    '_DunkSeat',
    '_ESCDoorL',
    '_ESCDoorL',
    '_ESCDoorL04',
    '_ESCDoorL05',
    '_ESCDoorL05',
    '_ESCDoorL06',
    '_ESCDoorR',
    '_ESCDoorR',
    '_ESCDoorR05',
    '_FMDoor',
    '_FMDoor',
    '_FMDoor01',
    '_FMDoor01N',
    '_FMDoor02',
    '_FMDoor03',
    '_FMDoor04',
    '_FMDoor05',
    '_FMDoor06',
    '_FMDoor07',
    '_FMDoor08',
    '_FMDoorN',
    '_FMDoorN01',
    '_Ferris',
    '_FunTeeth',
    '_GarbCanA',
    '_GasSign',
    '_HSdinger',
    '_HattrickDoor',
    '_Hattrick_gate',
    '_Ind_DoorStr02',
    '_Ind_DoorStr1',
    '_Ind_MedicalDoor',
    '_Ind_PoliceDoor',
    '_JanDoor02',
    '_JanDoors00',
    '_JanDoors01',
    '_JanDoors02',
    '_JanDoors03b',
    '_JanSwtch00',
    '_JanSwtch01',
    '_JanSwtch02',
    '_JanSwtch03a',
    '_LckrGymA01',
    '_LckrGymA02',
    '_LckrGymA03',
    '_LckrGymB',
    '_LckrGymB01',
    '_LckrGymB02',
    '_LckrGymB03',
    '_LckrGymM',
    '_LifeGrd',
    '_MeatPlant_boltcutters_FDoorC01',
    '_MeatPlant_hide_FDoorC02',
    '_MeatPlant_hide_FDoorC03',
    '_NLock01A',
    '_NLock01A',
    '_NLock01A01',
    '_NLock01A02',
    '_NLock01B',
    '_NLock01B01',
    '_NLock01B02',
    '_NLock02A',
    '_NLock02A01',
    '_NLock02A02',
    '_NLock02A03',
    '_NLock02B',
    '_NLock02B01',
    '_NLock02B02',
    '_NLock02B03',
    '_NLock02B04',
    '_NLock02B05',
    '_NLock02B06',
    '_NLock02B07',
    '_NLock03B',
    '_NerdPath_AsySwtch',
    '_NerdPath_BRDoor',
    '_PAn_Prep_ESCDoorR',
    '_Picnic',
    '_PokerTbl',
    '_RA_DoorStr02',
    '_RA_DoorStr05',
    '_RA_DoorStr06',
    '_RA_DoorStr07',
    '_RA_DoorStr08',
    '_RA_DoorStr09',
    '_RA_PrepDoor02',
    '_RA_PrepDoor03',
    '_RA_PrepDoor04',
    '_RA_PrepDoor05',
    '_RA_PrepDoor06',
    '_RA_PrepDoor07',
    '_RA_PrepDoor08',
    '_RA_PrepDoor09',
    '_RA_PrepDoor10',
    '_RA_PrepDoor11',
    '_RA_PrepDoor12',
    '_RA_PrepDoor13',
    '_RA_PrepDoor14',
    '_RA_PrepDoor15',
    '_RG_FW_enter_m',
    '_RG_FW_enter_s',
    '_RG_FW_exit_m',
    '_RG_FW_exit_s',
    '_RG_RC_enter_m',
    '_RG_RC_enter_s',
    '_RG_RC_exit_m',
    '_RG_RC_exit_s',
    '_RG_SQ_enter_m',
    '_RG_SQ_exit_m',
    '_RMailbox',
    '_SCFount',
    '_SCLock01',
    '_SC_Crest',
    '_SCgrdoor',
    '_SCgrdoor01',
    '_SCgrdoor02',
    '_SandCasl',
    '_ScGate_Observatory',
    '_Squid',
    '_Stable',
    '_TINDUST_BAR_DOOR_01',
    '_TINDUST_BAR_DOOR_02',
    '_TINDUST_BAR_DOOR_03',
    '_TINDUST_ELECTRIC_SHUTOFF',
    '_TINDUST_FIRE_DOOR_01',
    '_TINDUST_FIRE_DOOR_02',
    '_TINDUST_REDSTAR_GATE_01',
    '_TINDUST_SHDOOR_03',
    '_TINDUST_SHDOOR_04',
    '_TINDUST_SHDOOR_05',
    '_TINDUST_SHDOOR_06',
    '_TINDUST_SHDOOR_07',
    '_TadBackDoorL',
    '_TadBackDoorR',
    '_TadFrontDoorL',
    '_TadFrontDoorR',
    '_TadGates02',
    '_TadShud',
    '_TadShud01',
    '_TadShud02',
    '_TadShud03',
    '_TadShud04',
    '_TadShud05',
    '_TennWash',
    '_auditorium_doorR',
    '_bu_DoorStr10',
    '_bu_PrepDoor13',
    '_bu_PrepDoor14',
    '_bu_PrepDoor15',
    '_bu_PrepDoor16',
    '_bu_PrepDoor17',
    '_bu_PrepDoor18',
    '_bu_PrepDoor19',
    '_bu_PrepDoor20',
    '_bu_PrepDoor21',
    '_bu_PrepDoor22',
    '_bu_PrepDoor23',
    '_bu_PrepDoor24',
    '_bu_PrepDoor25',
    '_funCurtn',
    '_funCurtn01',
    '_fun_MazeEntryDoor',
    '_gdorm_DoorR',
    '_gyml_doorR',
    '_hardwareback',
    '_iboxing_BoxRopes',
    '_iboxing_BoxRopes01',
    '_iboxing_BoxRopes02',
    '_iboxing_BoxRopes03',
    '_iboxing_ESCDoorL',
    '_iboxing_ESCDoorL01',
    '_iboxing_ESCDoorR',
    '_iboxing_ESCDoorR01',
    '_iboxing_IntDoor02',
    '_icecream',
    '_icomshp_Basement',
    '_ifunhous_FLbBook',
    '_ifunhous_FLbLader',
    '_ifunhous_FMTrapDr00L',
    '_ifunhous_FMTrapDr00O',
    '_ifunhous_FMTrapDr01L',
    '_ifunhous_FMTrapDr01O',
    '_ifunhous_FMTrapDr02L',
    '_ifunhous_FMTrapDr02O',
    '_ifunhous_FMTrapDr03L',
    '_ifunhous_FMTrapDr03O',
    '_ifunhous_FMTrapSw',
    '_ifunhous_FMTrapSw01',
    '_ifunhous_FMTrapSw01b',
    '_ifunhous_FMTrapSw02',
    '_ifunhous_FMTrapSw02b',
    '_ifunhous_FMTrapSw03',
    '_ifunhous_FMTrapSw03b',
    '_ifunhous_FMTrapSw04',
    '_ifunhous_FMTrapSw04b',
    '_ifunhous_FMTrapSw05',
    '_ifunhous_FMTrapSw05b',
    '_ifunhous_FMTrapSw06',
    '_ifunhous_FMTrapSw06b',
    '_ifunhous_FMTrapSw07',
    '_ifunhous_FMTrapSw07b',
    '_ifunhous_FMTrapSwb',
    '_ifunhous_Reeper00b',
    '_ifunhous_Reeper01',
    '_ifunhous_Reeper02',
    '_ifunhous_funMinerB',
    '_ifunhous_funMinerD',
    '_ifunhous_funMinerG',
    '_ifunhous_funMinerH',
    '_ifunhous_funMinerI',
    '_ischool_CafDoor2R',
    '_ischool_Door00',
    '_ischool_Door02',
    '_ischool_Door05',
    '_ischool_Door06',
    '_ischool_Door09',
    '_ischool_Door19',
    '_ischool_Door21',
    '_ischool_Door23',
    '_ischool_Door24',
    '_ischool_Door25',
    '_ischool_Door28',
    '_ischool_Door30',
    '_ischool_FrontDoorR',
    '_ischool_StoreDoor',
    '_ischool_fountains_SCFount',
    '_ischool_fountains_SCFount03',
    '_ischool_fountains_SCFount04',
    '_ischool_fountains_SCFount05',
    '_ischool_fountains_SCFount06',
    '_ischool_fountains_SCFount09',
    '_ischool_fountains_SCFount12',
    '_ischool_fountains_SCFount15',
    '_ischool_fountains_SCFount16',
    '_observatory_doorR',
    '_pChair',
    '_pool_doorR',
    '_tbarrels_Sbarels1',
    '_tbusiness_BMXGate',
    '_tbusiness_GarbCanA08',
    '_tbusiness_MotelDor',
    '_trich_TadGates',
    '_trich_TadGates01',
    '_tschool_AutoShopFGate',
    '_tschool_BoysDormR',
    '_tschool_FieldR',
    -- '_tschool_FrontGate', -- DISABLE
    '_tschool_GirlsDormR',
    '_tschool_GymR',
    '_tschool_LibraryR',
    -- '_tschool_ParkingGate', -- DISABLE
    '_tschool_PoolR',
    '_tschool_PreppyR',
    '_tschool_SchoolFrontDoorR',
    '_tschool_SchoolLeftFrontDoor',
    '_valeHotelDoor',
  }
end
