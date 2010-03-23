Date: Mon, 22 Mar 2010 21:57:03 -0700 (PDT)
Message-Id: <20100322.215703.77339158.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4BA84607.7030304@redhat.com>
References: <4BA82186.3010204@redhat.com> <1269318470.3552.54.camel@calx>
	<4BA84607.7030304@redhat.com>
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
To: amwang@redhat.com
Cc: fubar@us.ibm.com, nhorman@tuxdriver.com, netdev@vger.kernel.org, mpm@selenic.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, gospo@redhat.com, bonding-devel@lists.sourceforge.net

From: Cong Wang <amwang@redhat.com>
Date: Tue, 23 Mar 2010 12:39:35 +0800

> How could you let the bridge know netpoll is not sent to
> the one that doesn't support netpoll during setup? This will
> be complex, I am afraid.

Why does this matter at all?

I told you in another mail that we should do away with
these callbacks and all the crazy 'npinfo' assignments
and just do it in the generic code.
