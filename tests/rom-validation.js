const NesRomFile = require('nes-test').NesRomFile;

let romData;

describe('ROM validation test', () => {

  beforeEach(() => {
    // Rom paths are relative to the test script
    romData = new NesRomFile('../build/deepdown.nes');
  })

  it('has a valid 16 byte header', async () => {
    expect(romData.hasValidHeader()).toEqual(true);
  });

  it('is marked as using nrom mapper', async () => {
    expect(romData.getMapper()).toEqual(0);
  });

});