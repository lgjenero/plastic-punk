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
    next: buildTownHallMessage,
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
}
