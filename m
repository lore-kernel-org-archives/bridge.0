Date: Fri, 24 Sep 2004 09:17:25 -0700
Message-ID: <20040924161725.GA29731@bougret.hpl.hp.com>
References: <C6D44AA99ECEB540A5498F15F92DA07DDD38FD@amperion01>
	<20040924052343.24990.qmail@web41012.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924052343.24990.qmail@web41012.mail.yahoo.com>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: [Bridge] Re: Problem COnnecting AP from Mobile Node
Reply-To: jt@hpl.hp.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Yong Chu Eu =?iso-8859-1?B?KNHu19PT0yk=?= <ceyong@yahoo.com>
Cc: bridge@osdl.org, linux-help@houseofcraig.net, hostap@shmoo.com

On Thu, Sep 23, 2004 at 10:23:43PM -0700, Yong Chu Eu (??????) wrote:
> Thanks for kindly advice,Another question:
> 
> since i have 2 AP,how do i set the routing(static) between 2 AP if the
> mobile node roaming between this 2 AP? 
> 
> Any idea?

	Real APs use bridging, at L2, and therefore you just need to
place them in the same subnet and connect them on the same network
with no router between them.

	Jean
