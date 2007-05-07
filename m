From: =?iso-8859-1?Q?Ferm=EDn_Gal=E1n_M=E1rquez?= <fermin.galan@cttc.es>
Date: Mon, 7 May 2007 20:32:17 +0200
Message-ID: <005301c790d6$0d61c1e0$303d5854@cttc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Performance and limitations of virtual bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.osdl.org, xen-users@lists.xensource.com

Hi,

Is there a limit in the number of interfaces a virtual bridge (created with
brctl) can support without having a severe impact in performance?

I guess that there is no absolute answer for that question :), but maybe
there is some kind of procedure/tool to know the "stress" or "load" that a
virtual bridge is supporting in a given moment (in a similar way that a
"top" can show you the CPU load).

My question is due to I'm using a virtual bridge with 14 interfaces (each
interface correspond to a Xen virtual machine in the same physical host)
and, given that I'm experiencing transmission delays in the network
supported by the bridge, I'm suspecting about a loss of performance of it.
=20
Thanks in advance!

Best regards,

--------------------
Ferm=EDn Gal=E1n M=E1rquez
CTTC - Centre Tecnol=F2gic de Telecomunicacions de Catalunya
Parc Mediterrani de la Tecnologia, Av. del Canal Ol=EDmpic s/n, 08860
Castelldefels, Spain
Room 1.02
Tel : +34 93 645 29 12
Fax : +34 93 645 29 01
Email address: fermin dot galan at cttc dot es=20



