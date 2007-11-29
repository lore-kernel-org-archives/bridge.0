Date: Thu, 29 Nov 2007 14:52:31 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] bridge in 'hub' mode possible?
Message-ID: <20071129145231.281ddb33@freepuppy.rosehill>
In-Reply-To: <36797.204.10.124.3.1196374593.squirrel@squirrel.ouraynet.com>
References: <200711282000.lASK04sR013906@smtp2.linux-foundation.org>
	<8A55DBB97B4FBF4D9A6F23C92FE0F117EA45D6@BE08.exg3.exghost.com>
	<36797.204.10.124.3.1196374593.squirrel@squirrel.ouraynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: kevin@ouraynet.com
Cc: bridge@lists.linux-foundation.org

On Thu, 29 Nov 2007 15:16:33 -0700 (MST)
kevin@ouraynet.com wrote:

> Was a solution for this ever reached? I am needing a snort type solution
> myself as my new switches don't support mirroring.
> 
> Could the packet delivery of the bridge be modified to deliver to all
> interfaces?  Any ideas where I should start breaking things in the source?
> 
> Thanks much
> Kevin Karsh
> 

You can use the tc actions to mirror.

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
