Return-Path: <davem@davemloft.net>
Date: Wed, 27 May 2020 11:35:24 -0700 (PDT)
Message-Id: <20200527.113524.946608619523725892.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200527135124.1082844-1-arnd@arndb.de>
References: <20200527135124.1082844-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: multicast: work around clang bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: arnd@arndb.de
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, kuba@kernel.org, tglx@linutronix.de

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 May 2020 15:51:13 +0200

> Clang-10 and clang-11 run into a corner case of the register
> allocator on 32-bit ARM, leading to excessive stack usage from
> register spilling:
> 
> net/bridge/br_multicast.c:2422:6: error: stack frame size of 1472 bytes in function 'br_multicast_get_stats' [-Werror,-Wframe-larger-than=]
> 
> Work around this by marking one of the internal functions as
> noinline_for_stack.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=45802#c9
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
