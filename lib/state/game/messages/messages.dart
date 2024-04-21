import 'package:plastic_punk/state/game/messages/message.dart';

abstract class Messages {
  //
  // story messages
  //

  static const welcomeMessage = Message(
    title: 'Welcome to Plastic Punk!',
    message:
        'In a world where the once blue and green Earth is now shrouded in shades of gray and white, blanketed by the remnants of our past - plastic. A once marvel of human innovation has become our planet\'s undoing, seeping into our soils, choking our waters, and suffocating our air. But not all hope is lost. You, brave pioneer, have emerged in the midst of despair, bearing the light of change, the promise of a new dawn.',
    links: [],
    // next: buildTownHallMessage,
  );

  static const buildTownHallMessage = Message(
    title: 'Foundation of Hope: Building the Town Hall',
    message: '''
Commander,

As we embark on this monumental journey to cleanse our world and foster a new era of sustainability, our first task lies in establishing a beacon of leadership and unity. The construction of the Town Hall is not merely about erecting walls and a roof; it's about laying down the cornerstone of our future civilization, a hub from which our vision for a cleaner, greener world will radiate.

This Town Hall will serve as the heart of our community, where decisions are made, where innovations are born, and where every individual's voice can be heard. It will be the nerve center for our operations, guiding us in our mission to expand the cleaned-up areas, innovate new recycling methods, and unite the people under a common cause.

In this endeavor, every hand, every mind, and every soul is vital. Together, we will construct more than just a building; we will build a testament to human resilience and our commitment to the planet.

Let us take this step together, laying the foundation not just for our Town Hall, but for the hope of a world reborn. The path ahead is long and fraught with challenges, but in unity, there is strength. In action, there is hope.

Onward to a cleaner, brighter future. The blueprint of our Town Hall awaits your command. Let's build not just a structure, but a legacy.
''',
    links: [],
  );

  //
  // building info messages
  //

  static const townHallInfoMessage = Message(
    title: 'Town Hall',
    message:
        'The Town Hall is the heart of your community. It is the center of your operations, politcal  where you can manage your city, view your progress, and make important decisions. It is also the place where you can receive important messages and updates.',
    links: [],
  );

  static const transportationInfoMessage = Message(
    title: 'Transportation',
    message:
        'Transportation is important to effectively connect your community. Transportation is a major source of pollution and greenhouse gas emissions. <link:1> is essential for reducing the environmental impact of transportation.',
    links: [
      MessageLink(
          id: '1',
          text: 'Public transportation',
          url:
              'https://climate.mit.edu/explainers/public-transportation#:~:text=According%20to%20the%20International%20Energy,passenger%20transit%20modes%2C%202019.%E2%80%9D'),
    ],
  );

  static const gardenInfoMessage = Message(
    title: 'Garden',
    message:
        'The Garden is a place where you can grow food for the community. Taking control of food production is essential for increasing the healt of the community but also of the environment. Organic farming <link:1>, removes use of <link:2> and <link:3>.',
    links: [
      MessageLink(
          id: '1', text: 'restores soil', url: 'https://www.sciencedirect.com/science/article/pii/S1658077X2300070X'),
      MessageLink(id: '2', text: 'dangrous chemicals', url: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9101768/'),
      MessageLink(id: '3', text: 'improves health', url: 'https://pubmed.ncbi.nlm.nih.gov/32519524/'),
    ],
  );

  static const houseInfoMessage = Message(
    title: 'House',
    message:
        'The House is where your citizens live. It is important to provide a safe and comfortable environment for your citizens. <link:1> and <link:2> are essential for the well-being of your citizens.',
    links: [
      MessageLink(
          id: '1',
          text: 'Housing quality',
          url:
              'https://health.gov/healthypeople/priority-areas/social-determinants-health/literature-summaries/quality-housing'),
      MessageLink(
          id: '2',
          text: 'ecological building methodology',
          url: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2920980/'),
    ],
  );

  static const researchCentreInfoMessage = Message(
    title: 'Research Centre',
    message:
        'The Research Centre is where you can research new technologies and innovations. It is essential for the development of your community and the environment.',
    links: [],
  );

  static const plasticsRecyclingInfoMessage = Message(
    title: 'Plastics Recycling Facility',
    message:
        'The Plastics Recycling Facility is where you can recycle plastics. Recycling plastics <link:1> and requires more research and investment, but is essential in the cleanup efforts.',
    links: [
      MessageLink(
          id: '1',
          text: 'is not without issues',
          url:
              'https://www.theguardian.com/environment/2023/may/24/recycled-plastic-more-toxic-no-fix-pollution-greenpeace-warns'),
    ],
  );

  static const plasticsEnergyInfoMessage = Message(
    title: 'Plastics to Energy Facility',
    message:
        'The Plastics to Energy Facility is where you can convert plastics into energy. Converting plastics into energy <link:1> and requires implementing it with care, but can help as the interim solition together with reducing demand for plastics.',
    links: [
      MessageLink(
          id: '1',
          text: 'is not a permanent solution',
          url: 'https://www.nationalgeographic.com/environment/article/should-we-burn-plastic-waste'),
    ],
  );

  static const waterTreatmentInfoMessage = Message(
    title: 'Water Treatment Plant',
    message:
        'The Water Treatment Plant is where you can clean and purify water. Freshwater and drinking water can contain <link:1> and <link:2>.',
    links: [
      MessageLink(
          id: '1', text: 'dangrous chemicals', url: 'https://www.niehs.nih.gov/health/topics/agents/water-poll'),
      MessageLink(id: '2', text: 'microplastics', url: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6449537/'),
    ],
  );

  static const parkInfoMessage = Message(
    title: 'Park',
    message:
        'The Park is a place where your citizens can relax and enjoy nature. Studies show how <link:1> of the citizens.',
    links: [
      MessageLink(
          id: '1',
          text: 'green spaces effect the well-being',
          url: 'https://www.sciencedirect.com/science/article/abs/pii/S1618866715001016'),
    ],
  );

  static const solarPanelsInfoMessage = Message(
    title: 'Solar Panel Facility',
    message:
        'The Solar Panel Facility is where you can generate electricity from the sun. Green energy sources are esseantial in <link:1>.',
    links: [
      MessageLink(
          id: '1',
          text: 'reducing the ecologial impact',
          url: 'https://www.sciencedirect.com/science/article/abs/pii/S0959652621002481'),
    ],
  );

  static const waterCleanupInfoMessage = Message(
    title: 'Water Cleanup Facility',
    message:
        'The Water Cleanup Facility is where you clean water bodies of enviromental pollution. All oceans and seas and most rivers and lakes are polluted by <link:1> and <link:2>.',
    links: [
      MessageLink(id: '1', text: 'runoff', url: 'https://oceanservice.noaa.gov/facts/pollution.html'),
      MessageLink(
          id: '2', text: 'plastics', url: 'https://www.sciencedirect.com/science/article/pii/S2405844020315528'),
    ],
  );

  static const educationCentreInfoMessage = Message(
    title: 'Education Centre',
    message:
        'The Education Centre is where you create spread the mission and share technology for the plastics cleanup cause. Education <link:1> and is one of the best tools for getting everybody onbard with the cause.',
    links: [
      MessageLink(
          id: '1',
          text: 'plays a role in environmental quality',
          url: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9978384'),
    ],
  );

  static const badHousingInfoMessage = Message(
    title: 'Convenional Housing',
    message:
        'Conventional Housing produces more pollution and causes more health issues. Also conventional housing does not stimulate reducing the demand for plastics, using sustainable transpotration and other green technologies.',
  );

  static const plasticsFactoryInfoMessage = Message(
    title: 'Plastics Factory',
    message:
        'Plastics Factory produces plastics and is a major source of pollution. The factory will spread the pollution to the surrounding area. You need to act fast and convice the factory to convert to your technology.',
  );

  static const roadInfoMessage = Message(
      title: 'Unsustainable transportation',
      message:
          'Using cars as the main transportation method is not sustainable. Cars <link:1> (GHG, noise, chemicals) and <link:2> and streas than public transportation.',
      links: [
        MessageLink(
          id: '1',
          text: 'produce more pollution',
          url:
              'https://climate.mit.edu/explainers/public-transportation#:~:text=Public%20transportation%20gets%20people%20where,large%20city%20may%20carry%20thousands.',
        ),
        MessageLink(id: '2', text: 'cause more accidents', url: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5906382/')
      ]);

  static const badTownHallInfoMessage = Message(
    title: 'Town Hall',
    message:
        'The Town Hall is the heart of the community. It is wher the policies are therfore the future of the community is decided.',
    links: [],
  );

  //
  // technology info messages
  //

  static const plasticsReduceInfoMessage = Message(
    title: 'Plastics Usage Reduction',
    message:
        'The Plastics Usage Reduction technology is the first step in reducing the demand for plastics. <link:1>, especially, create great stress on the environment and should be avoided wherever possible.',
    links: [
      MessageLink(
          id: '1',
          text: 'Single use plastics',
          url:
              'https://www.pbs.org/wnet/peril-and-promise/2023/11/how-single-use-plastics-hurt-our-oceans-and-warm-our-planet/'),
    ],
  );

  static const plasticsReuseInfoMessage = Message(
    title: 'Plastics Reuse',
    message:
        'The Plastics Reuse technology is the next step in reducing the demand for plastics. In our efforts for reducing the plastics pollution plastic waste can be <link:1>.',
    links: [
      MessageLink(
          id: '1',
          text: 'reused in a very creative vays',
          url: 'https://news.stanford.edu/2023/07/18/reusing-plastic-waste-infrastructure/'),
    ],
  );

  static const plasticsRecycleInfoMessage = Message(
    title: 'Plastics Recycling',
    message:
        'Plastics Recycling in some form will be necessary in order to create a circular economy for plastic products. Right now plastic recycling <link:1>, but <link:2> and more research and investments is needed.',
    links: [
      MessageLink(
          id: '1',
          text: 'reused in a very creative vays',
          url: 'https://www.theguardian.com/us-news/2024/feb/15/recycling-plastics-producers-report'),
      MessageLink(
          id: '2',
          text: 'advancements are being made',
          url: 'https://www.nationalgeographic.com/science/article/partner-content-innovations-in-recycling'),
    ],
  );

  static const waterTreatmentTechInfoMessage = Message(
    title: 'Water Treatment',
    message:
        'Water Treatment is the first step in cleaning and purifying water. Freshwater and drinking water can contain <link:1> and <link:2>.',
    links: [
      MessageLink(
          id: '1', text: 'dangrous chemicals', url: 'https://www.niehs.nih.gov/health/topics/agents/water-poll'),
      MessageLink(id: '2', text: 'microplastics', url: 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6449537/'),
    ],
  );

  static const waterCleanupTechInfoMessage = Message(
    title: 'Water Cleanup',
    message:
        'Water Cleanup is the next step in cleaning water bodies of enviromental pollution. All oceans and seas and most rivers and lakes are polluted by <link:1> and <link:2>.',
    links: [
      MessageLink(id: '1', text: 'runoff', url: 'https://oceanservice.noaa.gov/facts/pollution.html'),
      MessageLink(
          id: '2', text: 'plastics', url: 'https://www.sciencedirect.com/science/article/pii/S2405844020315528'),
    ],
  );

  //
  // Enemy messages
  //

  static const plasticsFactoryAlarm = Message(
    title: 'Plastics Factory Alarm!',
    message:
        'There is a plastics factory nearby that is producing a lot of pollution. The factory will spread the pollution to the surrounding area. You need to act fast and convice the factory to convert to your technology.',
    links: [],
  );

  static const badTownHallAlarm = Message(
    title: 'Plastisc Pollution Alarm!',
    message:
        'There is a community nearby that is producing a lot of pollution. The community will spread the pollution to the surrounding area. You need to act fast and convice the community to convert to sustainable technology.',
    links: [],
  );

  //
  // Info messages
  //

  static const researchUnavailable = Message(
    title: 'Research Unavailable',
    message: 'Research is not available at the moment. You need to build a Research Centre first.',
    links: [],
  );

  static const diplomacyUnavailable = Message(
    title: 'Diplomacy Unavailable',
    message: 'Diplomacy is not available at the moment. You need to build an Education Centre first.',
    links: [],
  );

  static const nowhereToBuild = Message(
    title: 'Cannot build the structure',
    message:
        'You cannot build the structure at the moment. There are no available tiles to build on. Plase build some tracks first.',
    links: [],
  );

  static const nowhereToHaveDiplomacy = Message(
    title: 'Diplomacy unavailable',
    message: 'There is no community to have diplomacy with.',
    links: [],
  );

  static const crossRedLineToHaveDiplomacy = Message(
    title: 'Diplomacy out of reach',
    message:
        'Cannot start diplomatic mission with this community. You need to come closer and cross the red line first.',
    links: [],
  );

  //
  // Level messages
  //

  static const level1Message = Message(
    title: 'Level 1',
    message:
        'Welcome to Level 1. In this level you will learn how to build a town hall and start your journey to clean the world. First you need to build a town hall. You can do that by opening the build menu',
    links: [],
  );

  static const level2Message = Message(
    title: 'Level 2',
    message:
        'Welcome to Level 2. In this level you will learn how to build build you community. You will build housing and food production facilities for your community.',
    links: [],
  );

  static const level3Message = Message(
    title: 'Level 3',
    message:
        'Welcome to Level 3. In this level you will learn how to research new technologies and innovations. You will build a research centre and start researching new technologies.',
    links: [],
  );

  static const level4Message = Message(
    title: 'Level 4',
    message:
        'Welcome to Level 4. In this level you will learn how to recycle plastics. You will research new technologies and build a plastics recycling facility to start recycling plastics.',
    links: [],
  );

  static const level5Message = Message(
    title: 'Level 5',
    message:
        'Welcome to Level 5. In this level you will learn how to secure clean drinking water. You will research new technologies and build a water treatment plant to start producing clean drinking water.',
    links: [],
  );

  static const level6Message = Message(
    title: 'Level 6',
    message:
        'Welcome to Level 6. In this level you will learn how to produce clean energy and ensure well being of the community. You will build a park and solar panel facility.',
    links: [],
  );

  static const level7Message = Message(
    title: 'Level 7',
    message:
        'Welcome to Level 7. In this level you will learn how to clean up water bodies. You will research new technologies and build a water cleanup facility to start cleaning up our oceans.',
    links: [],
  );

  static const level8Message = Message(
    title: 'Level 8',
    message:
        'Welcome to Level 8. In this level you will learn how to educate the community and spread the mission. If you do not bring other communites together we will never solve the pollution problem. Just be careful when crossing that red line, be prepared to intensify your cleaning efforts.',
    links: [],
  );

  static const level9Message = welcomeMessage;
}
