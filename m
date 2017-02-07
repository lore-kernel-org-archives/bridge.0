Return-Path: <davem@davemloft.net>
Date: Mon, 06 Feb 2017 22:53:35 -0500 (EST)
Message-Id: <20170206.225335.2275258471740874933.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1486227909-18319-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1486227909-18319-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/4] bridge: improve cache utilization
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat,  4 Feb 2017 18:05:05 +0100

> This is the first set which begins to deal with the bad bridge cache
> access patterns. The first patch rearranges the bridge and port structs
> a little so the frequently (and closely) accessed members are in the same
> cache line. The second patch then moves the garbage collection to a
> workqueue trying to improve system responsiveness under load (many fdbs)
> and more importantly removes the need to check if the matched entry is
> expired in __br_fdb_get which was a major source of false-sharing.
> The third patch is a preparation for the final one which
> If properly configured, i.e. ports bound to CPUs (thus updating "updated"
> locally) then the bridge's HitM goes from 100% to 0%, but even without
> binding we get a win because previously every lookup that iterated over
> the hash chain caused false-sharing due to the first cache line being
> used for both mac/vid and used/updated fields.
> 
> Some results from tests I've run:
> (note that these were run in good conditions for the baseline, everything
>  ran on a single NUMA node and there were only 3 fdbs)
> 
> 1. baseline
> 100% Load HitM on the fdbs (between everyone who has done lookups and hit
>                             one of the 3 hash chains of the communicating
>                             src/dst fdbs)
> Overall 5.06% Load HitM for the bridge, first place in the list
> 
> 2. patched & ports bound to CPUs
> 0% Local load HitM, bridge is not even in the c2c report list
> Also there's 3% consistent improvement in netperf tests.

Looks great, series applied, thanks!
