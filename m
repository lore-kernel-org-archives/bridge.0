Date: Mon, 8 May 2006 09:52:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Re: Google SoC proposal (Tadeusz Andrzej Kad?ubowski)
Message-ID: <20060508095234.69a0b146@localhost.localdomain>
In-Reply-To: <20060508081547.GA21825@hell.org.pl>
References: <200605071901.k47J09tJ014231@smtp.osdl.org>
	<200605080034.k480YP4i026133@mail.bme.zju.edu.cn>
	<20060508081547.GA21825@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Tadeusz Andrzej =?UTF-8?B?S2FkxYJ1Ym93c2tp?= <yess@hell.org.pl>
Cc: zhangliang <liangzh@mail.bme.zju.edu.cn>, bridge@lists.osdl.org

On Mon, 8 May 2006 10:15:47 +0200
Tadeusz Andrzej Kadłubowski <yess@hell.org.pl> wrote:

> Thus wrote zhangliang:
> > 
> > I think the prorosal is very good, I also want to do something for it, but
> > first we should have some more knowledge about rstp, Now what only I can do
> > is to read librstp, but I find that is so difficult to understand rstp, can
> > u give some more info about it?
> 
> Apart from reading librstp (which is considered to be messy etc.) we have two
> main sources:
> 
> a) The RSTP standard itself can be downloaded from the IEEE webpage for free.
> It's code-number is 802.1d. Don't be put off by it's technical language.
> 
> b) RSTP is based on STP. We have a decent working STP implementation inside the
> Linux kernel - it can give a general idea of how to implement some parts of
> RSTP.
> 

There was also a version of RSTP done for ucLinux that I archived at:
	http://developer.osdl.org/shemminger/prototypes/rstp-2.4.zip

But, I don't want RSTP to be in the kernel.
