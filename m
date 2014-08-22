Return-Path: <davem@davemloft.net>
Date: Fri, 22 Aug 2014 12:28:31 -0700 (PDT)
Message-Id: <20140822.122831.451083152510385540.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20140822130609.GA19576@ada>
References: <20140822130609.GA19576@ada>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] br_multicast: Replace rcu_assign_pointer()
 with RCU_INIT_POINTER()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bernat.ada@gmail.com
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org

From: Andreea-Cristina Bernat <bernat.ada@gmail.com>
Date: Fri, 22 Aug 2014 16:06:09 +0300

> The use of "rcu_assign_pointer()" is NULLing out the pointer.
> According to RCU_INIT_POINTER()'s block comment:
> "1.   This use of RCU_INIT_POINTER() is NULLing out the pointer"
> it is better to use it instead of rcu_assign_pointer() because it has a
> smaller overhead.
 ...
> Signed-off-by: Andreea-Cristina Bernat <bernat.ada@gmail.com>

Applied.
