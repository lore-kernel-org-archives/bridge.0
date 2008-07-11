Message-ID: <4876FDF0.1030807@iki.fi>
Date: Fri, 11 Jul 2008 09:30:08 +0300
From: =?ISO-8859-1?Q?Timo_Ter=E4s?= <timo.teras@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: =?UTF-8?B?VGltbyBUZXLDpHM=?= <timo.teras@gmail.com>
Subject: [Bridge] bridging with gre tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org

Hi all,

It looks the current kernel still do not support bridging over gre
tunnels.

I did find an old patch for ip_gre that would enable this [1]. But
it needs porting from 2.4 to 2.6 kernels and looks like it needs
cleaning up too.

Is there newer/better patches to achieve this? Any thoughts about
doing bridging with gre tunnels?

Cheers,
  Timo

[1] http://mailman.ds9a.nl/pipermail/lartc/2003q4/010327.html
