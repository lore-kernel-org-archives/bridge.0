Date: Thu, 2 Dec 2004 11:20:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge in 'hub' mode possible?
Message-Id: <20041202112002.444fdff0@dxpl.pdx.osdl.net>
In-Reply-To: <87ekic1p6w.fsf@aka.i.naked.iki.fi>
References: <87d5xw4uui.fsf@aka.i.naked.iki.fi>
	<20041129102432.24888dad@zqx3.pdx.osdl.net>
	<87ekic1p6w.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Nuutti Kotivuori <naked@iki.fi>
Cc: bridge@osdl.org

Have you tried "brctl setageingtime br0 0" to turn off 
forwarding table?
