Date: Mon, 15 Nov 2010 08:19:27 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20101115081927.0fd8e614@nehalam>
In-Reply-To: <201011152123.HHB21896.HFOOVSMFOtLJQF@I-love.SAKURA.ne.jp>
References: <20101114211201.678755903@vyatta.com>
	<201011152123.HHB21896.HFOOVSMFOtLJQF@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/5] bridge: RCU annotation and cleanup
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, eric.dumazet@gmail.com

On Mon, 15 Nov 2010 21:23:37 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> > +			rp = rcu_dereference(hlist_next_rcu(rp->next));  
> 
> I think this one is hlist_next_rcu(rp).

Yes, you are correct.

-- 
