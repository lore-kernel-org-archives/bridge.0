In-Reply-To: <45F8E00A.7050908@gmail.com>
Message-ID: <OF2B235CAE.4C560998-ON8525729F.005E1121-8525729F.005E4D58@smsc.com>
From: Marc.Obbad@smsc.com
Date: Thu, 15 Mar 2007 13:10:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] rstp for 2.4 kernel: port state keeps changing
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: ptiwatthanont@gmail.com
Cc: bridge-bounces@lists.osdl.org, bridge@linux-foundation.org, netdev@vger.kernel.org

For me, I ma building for Embedded platform.
Go to Directory where the Makefile is and do this:


make -C  $LINUX_DIR  SUBDIRS=3D$PWD  modules
LINUX_DIR should point to LINUX directory

LINUX_DIR=3D/home/swdev/PPC/linux/   as example

-Marc.



                                                                           =
                                            =20
             Pasakorn Tiwatthanont                                         =
                                            =20
             <ptiwatthanont@gmail.com>                                     =
                                            =20
             Sent by:                                                      =
                                          To=20
             bridge-bounces@lists.osdl.org               Marc Obbad/SMSC@SM=
SC                                          =20
                                                                           =
                                          cc=20
                                                         bridge-bounces@lis=
ts.osdl.org, bridge@linux-foundation.org,   =20
             03/15/2007 01:56 AM                         netdev@vger.kernel=
.org                                        =20
                                                                           =
                                     Subject=20
                                                         Re: [Bridge] rstp =
for 2.4 kernel: port state keeps changing   =20
                      Please respond to                                    =
                                            =20
                   ptiwatthanont@gmail.com                                 =
                                            =20
                                                                           =
                                            =20
                                                                           =
                                            =20
                                                                           =
                                            =20
                                                                           =
                                            =20




Dear,=00=A0=A0=A0 I tried to patch rstp-2.4.zip but I can not compile it.
If don't take your time too much, please explain me how to use
this patch files.

Thank you very much
iPAS

Marc.Obbad@smsc.com wrote:
      I have downloaded RSTP from this site:


            http://developer.osdl.org/shemminger/prototypes/rstp-2.4.zip


      -Marc






                   Stephen Hemminger

                   <shemminger@linux-foundation.org>

                   Sent by:
      To
                   bridge-bounces@lists.osdl.org               Marc Obbad/S=
MSC@SMSC

      cc
                                                               netdev@vger.=
kernel.org, bridge@linux-foundation.org

                   03/09/2007 01:55 PM
      Subject
                                                               Re: [Bridge]=
 rstp for 2.4 kernel: port state keeps
      changing










      On Fri, 9 Mar 2007 12:24:40 -0500
      Marc.Obbad@smsc.com wrote:


            Hi,

            I am using RSTP for 2.4 kernel.


      RSTP is not in the mainline kernel tree. Please post the patch or a w=
here the
      source can be downloaded.

      --
      Stephen Hemminger <shemminger@linux-foundation.org>
      _______________________________________________
      Bridge mailing list
      Bridge@lists.osdl.org
      https://lists.osdl.org/mailman/listinfo/bridge


      _______________________________________________
      Bridge mailing list
      Bridge@lists.osdl.org
      https://lists.osdl.org/mailman/listinfo/bridge

        _______________________________________________
      Bridge mailing list
      Bridge@lists.osdl.org
      https://lists.osdl.org/mailman/listinfo/bridge



