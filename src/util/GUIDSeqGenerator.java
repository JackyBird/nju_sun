package util;


import java.text.DecimalFormat;

public class GUIDSeqGenerator
{
  private static GUIDSeqGenerator instance;
  private static String seqGUID;
  private static int seq;
  private static final int MAX_SEQ = 99999;

  private GUIDSeqGenerator()
  {
    seq = 99999;
  }

  public static GUIDSeqGenerator getInstance() {
    if (instance == null) {
      instance = new GUIDSeqGenerator();
    }
    return instance;
  }

  public String newGUID()
  {
    StringBuilder sb = new StringBuilder();
    synchronized (this) {
      if (seq == 99999)
      {
        seqGUID = GUID.newGUID().toString().toUpperCase();
        seq = 1;
      }
      else {
        seq += 1;
      }
      sb.append(String.format("%s-%s", new Object[] { seqGUID, fillString(seq) }));
    }
    return sb.toString();
  }

  private String fillString(int p_seq) {
    DecimalFormat df = new DecimalFormat("00000");
    return df.format(p_seq);
  }
}
