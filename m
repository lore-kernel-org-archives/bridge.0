Return-Path: <davem@davemloft.net>
Date: Mon, 04 Nov 2019 11:15:39 -0800 (PST)
Message-Id: <20191104.111539.1483994068865626222.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20191104093651.16754-1-nikolay@cumulusnetworks.com>
References: <20191104093651.16754-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: fdb: eliminate extra
 port state tests from fast-path
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
Date: Mon,  4 Nov 2019 11:36:51 +0200

> When commit df1c0b8468b3 ("[BRIDGE]: Packets leaking out of
> disabled/blocked ports.") introduced the port state tests in
> br_fdb_update() it was to avoid learning/refreshing from STP BPDUs, it was
> also used to avoid learning/refreshing from user-space with NTF_USE. Those
> two tests are done for every packet entering the bridge if it's learning,
> but for the fast-path we already have them checked in br_handle_frame() and
> is unnecessary to do it again. Thus push the checks to the unlikely cases
> and drop them from br_fdb_update(), the new nbp_state_should_learn() helper
> is used to determine if the port state allows br_fdb_update() to be called.
> The two places which need to do it manually are:
>  - user-space add call with NTF_USE set
>  - link-local packet learning done in __br_handle_local_finish()
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thank you.
