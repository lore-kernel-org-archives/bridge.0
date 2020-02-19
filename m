Return-Path: <davem@davemloft.net>
Date: Wed, 19 Feb 2020 11:14:25 -0800 (PST)
Message-Id: <20200219.111425.339826041230667879.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200219151746.1050-1-madhuparnabhowmik10@gmail.com>
References: <20200219151746.1050-1-madhuparnabhowmik10@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: br_stp: Use built-in RCU list checking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: madhuparnabhowmik10@gmail.com
Cc: paulmck@kernel.org, frextrite@gmail.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, joel@joelfernandes.org, linux-kernel-mentees@lists.linuxfoundation.org

From: madhuparnabhowmik10@gmail.com
Date: Wed, 19 Feb 2020 20:47:46 +0530

> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> list_for_each_entry_rcu() has built-in RCU and lock checking.
> 
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
> by default.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Applied, thank you.
