Message-ID: <33094.63.170.215.71.1091592938.squirrel@www.osdl.org>
In-Reply-To: <20040804010230.GH21309@riseup.net>
References: <20040804010230.GH21309@riseup.net>
Date: Tue, 3 Aug 2004 21:15:38 -0700 (PDT)
Subject: Re: [Bridge] Sparc64 bug in 1.0.4
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
To: bridge@lists.osdl.org

>
> Under sparc64, with the bridge module loaded, running brctl addbr br0
> results in:
>
> add bridge failed: Operation not supported
> sys32_ioctl(brctl:6667): Unknown cmd fd(3) cmd(000089a0) arg(effffbf9)

What version is the kernel you are using? If it isn't 2.6.7 or later
it probably won't work.
