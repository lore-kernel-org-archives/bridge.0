From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20100302153209.74742a96@nehalam>
References: <20100301161658.5a61143b@nehalam>
	<1267520579.2964.27.camel@edumazet-laptop>
	<20100302095831.151c8bb5@nehalam>
	<1267553173.2839.9.camel@edumazet-laptop>
	<20100302153209.74742a96@nehalam>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 03 Mar 2010 07:09:04 +0100
Message-ID: <1267596544.2839.71.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH]  bridge: per-cpu packet statistics (v3)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

Le mardi 02 mars 2010 à 15:32 -0800, Stephen Hemminger a écrit :
> The shared packet statistics are a potential source of slow down
> on bridged traffic. Convert to per-cpu array, but only keep those
> statistics which change per-packet.
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> 

Thanks Stephen !

Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>


