Date: Thu, 29 Jul 2004 22:34:55 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
Subject: Re: [Bridge] Assertion failed in bridge code on 2.4.27-rc3
Message-ID: <20040729203455.GA6101@man.manty.net>
References: <20040728195957.GA2621@man.manty.net>
	<20040728132128.22bed751@dell_ss3.pdx.osdl.net>
	<20040728222722.GA2688@man.manty.net>
	<20040728162802.6a297248@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728162802.6a297248@dell_ss3.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, bridge@lists.osdl.org

> The code path for some ioctl's is different in 2.4 than 2.6 (it goes
> through IP in 2.4).  Therefore the following is needed.

Well... it cured the message, but the bridge used to work when we had the
messages, and now brctl gets stuck and doesn't exit.

Let me explain the thing...

Before this patch, in 2.4.27-rc3 we had those messages I told you about
yesterday, but the bridge was setup.

Now, with this patch you sent, brctl doesn't make the kernel output those
messages, but execution of:
	brctl addbr br0
does not end.

Hope that helps, if you need more info, just ask me.

Regards...
-- 
Manty/BestiaTester -> http://manty.net

PS: I won't be around during the weekend, I'm leaving tomorrow afternoon CET
