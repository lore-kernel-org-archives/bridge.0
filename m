Date: Mon, 26 Apr 2004 09:01:24 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] ethernet bridge + iptables
Message-Id: <20040426090124.272b7de8@dell_ss3.pdx.osdl.net>
In-Reply-To: <010701c42ba3$288f2570$41317d9e@keziah>
References: <010701c42ba3$288f2570$41317d9e@keziah>
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
To: Mark Sandford <J.M.Sandford@lboro.ac.uk>
Cc: bridge@osdl.org

On Mon, 26 Apr 2004 16:28:43 +0100
"Mark Sandford" <J.M.Sandford@lboro.ac.uk> wrote:

> I'm trying to get iptables working with ethernet bridging.

If you don't get a good answer here try the ebtables list:
	ebtables-user@lists.sourceforge.net

> I'm starting with a clean rh9 installation.  
> 
> I've tried applying the ebtables-brnf-5_vs_2.4.24.diff patch.  This compiles ok but my machine completely hangs moments after I bring the bridge up.
> 
> http://article.gmane.org/gmane.linux.network.bridge.ebtables.devel/221  describes same problem (I emailed author who just suggested moving on to newer kernel which is what I've tried)
> 
> I've since been using 2.4.25 kernel (and then 2.4.26).  Kernel compiles and the system doesn't hang when the bridge comes up but I don't seem to be able to get it to actually do the bridging.  (Bridging does work with initial rh9 install).  The ethernet cards work fine until I bring the bridge up.  After that I can't ping from the bridge or forward packets through the bridge.
> 
> I'm wondering whether I've incorrectly set/missed some options while configuring the kernel but I don't know what to try.
> 
> Any clues / pointers hugely appreciated.
> 
> Mark.
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Mark Sandford,
> Research Associate,
> Department of Electronic and Electrical Engineering,
> Loughborough University,
> Loughborough,
> Leicestershire.
> LE11 3TU
> 
> tel: (01509) 227079
> e-mail: <j.m.sandford@lboro.ac.uk>
> http://www.lboro.ac.uk/departments/el/
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
