Subject: Re: [Bridge] [PATCH] netlink message on bridge address change
From: Stephen Hemminger <shemminger@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0409300921430.13917-100000@dane-linux.ai.aiinet.com>
References: <Pine.LNX.4.44.0409300921430.13917-100000@dane-linux.ai.aiinet.com>
Content-Type: text/plain
Date: Thu, 30 Sep 2004 09:44:33 -0700
Message-Id: <1096562673.17672.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: dane@aiinet.com
Cc: bridge@osdl.org

On Thu, 2004-09-30 at 09:23 -0400, Dan Eble wrote:
> Is this an acceptable way to notify a daemon when a bridge address 
> changes?

Probably, but you need to do it against the 2.6 code (which is
different).  I consider the 2.4 pretty firmly frozen.

