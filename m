Date: Mon, 22 Mar 2010 21:59:36 -0700 (PDT)
Message-Id: <20100322.215936.113720990.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1269319861.3552.87.camel@calx>
References: <1269318470.3552.54.camel@calx> <4BA84607.7030304@redhat.com>
	<1269319861.3552.87.camel@calx>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC Patch 2/3] bridge: make bridge support netpoll
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mpm@selenic.com
Cc: fubar@us.ibm.com, amwang@redhat.com, nhorman@tuxdriver.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, gospo@redhat.com, bonding-devel@lists.sourceforge.net

From: Matt Mackall <mpm@selenic.com>
Date: Mon, 22 Mar 2010 23:51:01 -0500

> On Tue, 2010-03-23 at 12:39 +0800, Cong Wang wrote:
>> Matt Mackall wrote:
>> How could you let the bridge know netpoll is not sent to
>> the one that doesn't support netpoll during setup? This will
>> be complex, I am afraid.
> 
> I thought I saw a simple loop over bridge devices at poll time in your
> patch. So it should be a simple matter of skipping unsupported devices
> in that loop.

It's because of all that "assign ->npinfo to slaves" crap he has to do
the way his patches are currently implemented.

It's basically another sign that the design is wrong.
