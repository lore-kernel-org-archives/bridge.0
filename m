Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hhXPboyK2v72FwSZ0+xAP/i5XUCZDW7UBvYMvKOCkg8=;
	b=K9ULkexxXSpbUNJ/eON+hnJ6Wk6gP2/N9AIvirgJqPSGaP7BeDH4P4bAVUkSsedAaR
	IDTXzqa6XziA2/2aJHhaFy/Hcsod649eprq9B4JWPyOzilFMTKsDiDzsAz4TS0/b8SaP
	riyZSm1Lh+XEfg726/kglsJCb884CDak52DwI=
References: <20181111194104.GA4787@linux.ibm.com>
	<20181111194410.6368-33-paulmck@linux.ibm.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <58d41678-edc9-9212-718c-a922ab151eda@cumulusnetworks.com>
Date: Tue, 13 Nov 2018 02:29:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181111194410.6368-33-paulmck@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH tip/core/rcu 33/41] net/bridge: Replace
 call_rcu_bh() and rcu_barrier_bh()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>, peterz@infradead.org, fweisbec@gmail.com, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org, oleg@redhat.com, dhowells@redhat.com, edumazet@google.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, dipankar@in.ibm.com, joel@joelfernandes.org, akpm@linux-foundation.org, mingo@kernel.org

On 11/11/18 9:44 PM, Paul E. McKenney wrote:
> Now that call_rcu()'s callback is not invoked until after all bh-disable
> regions of code have completed (in addition to explicitly marked
> RCU read-side critical sections), call_rcu() can be used in place
> of call_rcu_bh().  Similarly, rcu_barrier() can be used in place of
> rcu_barrier_bh().  This commit therefore makes these changes.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
> Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <bridge@lists.linux-foundation.org>
> Cc: <netdev@vger.kernel.org>
> ---
>  net/bridge/br_mdb.c       |  2 +-
>  net/bridge/br_multicast.c | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 

Really like this change, makes life simpler.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

