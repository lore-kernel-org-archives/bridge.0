Message-ID: <33064.63.170.215.71.1091077856.squirrel@www.osdl.org>
In-Reply-To: <20040728191724.4afacdce.davem@redhat.com>
References: <20040728153725.7ace281c@dell_ss3.pdx.osdl.net>
	<20040728191724.4afacdce.davem@redhat.com>
Date: Wed, 28 Jul 2004 22:10:56 -0700 (PDT)
Subject: Re: [Bridge] Re: [PATCH] (1/4) propgate bridge internal MTU changes
From: shemminger@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org, Stephen Hemminger <shemminger@osdl.org>

>
> I assume these 4 patches are for 2.6.x?  I'll hit them tomorrow,
> regardless.
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge

There is one missing additional piece, the fdb RCU code needs
to use call_rcu().  Testing it now.



