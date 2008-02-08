Date: Thu, 7 Feb 2008 17:27:52 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080207172752.62c91767@extreme>
In-Reply-To: <478c82f00802070519j5214fc6ped4671c2a7dc249f@mail.gmail.com>
References: <478c82f00802070519j5214fc6ped4671c2a7dc249f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: unidirectional traffic and flooding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Alexander (Sasha) Sirotkin" <sasha.sirotkin@gmail.com>
Cc: bridge@osdl.org

On Thu, 7 Feb 2008 15:19:06 +0200
"Alexander (Sasha) Sirotkin" <sasha.sirotkin@gmail.com> wrote:

> Suppose there is a unidirectional traffic only (for instance UDP) to one of
> the devices connected to a bridge. At the beginning, the bridge will learn
> the location of this device from gracious ARP. However, after the timeout
> the bridge will forget this information and since there is no traffic from
> that device (remember, the traffic is unidirectional, i.e. to the device
> only) it will start flooding... and will continue to do so forever.
> 
> I have a feeling that I must be not the first person to encounter this
> problem. Any ideas ?
> 
You should check the 802.1d standard.

-- 
Stephen Hemminger <stephen.hemminger@vyatta.com>
