Date: Fri, 10 Sep 2004 22:30:11 +0200
Message-ID: <20040910223011.Q15021@macwheel.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: stappers@stappers.nl (Geert Stappers)
Subject: [Bridge] sparc64: add bridge failed: Operation not supported
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,

On a Sun Sparc Ultra5, where `uname -m` reports "sparc64",
and the bridge kernel modules is loaded (`insmod bridge`),
reports on `brctl addbr br0` with
add bridge failed: Operation not supported

That failure writes in /var/log/kern.log
sys32_ioctl(brctl:572): Unknown cmd fd(3) cmd(000089a0) arg(effffcbd)


My questions are:

* Are there succesfull reported sparc64 systems doing bridging?
* What should I do to get that sparc64 acting as a bridge?


Cheers
Geert Stappers
