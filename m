Return-Path: <davem@davemloft.net>
Date: Thu, 08 Mar 2012 00:25:35 -0800 (PST)
Message-Id: <20120308.002535.1307528364263033103.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120307082514.6293.59158.stgit@localhost.localdomain>
References: <20120307082514.6293.59158.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/2] bridge: br_log_state() s/entering/entered/
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: paulius.zaleckas@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date: Wed, 07 Mar 2012 10:25:14 +0200

> When br_log_state() is reporting state it should say "entered"
> istead of "entering" since state at this point is already
> changed.
> 
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>

Applied.
