Date: Thu, 10 Jun 2004 08:31:27 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040610083127.61a5296c@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040610041129.56613.qmail@web41006.mail.yahoo.com>
References: <20040610041129.56613.qmail@web41006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Bridging
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "&#26472;&#23376;&#20305; Yong Chu Eu" <ceyong@yahoo.com>
Cc: bridge@osdl.org

On Wed, 9 Jun 2004 21:11:29 -0700 (PDT)
"&#26472;&#23376;&#20305; Yong Chu Eu" <ceyong@yahoo.com> wrote:

> Hi,
> 
> Sorry,after i install bridging 1.4, even after i setup a new bridge to
> link between wlan0 & eth 0 but it seem lost after pc restart, i have to
> reset after restart. am i doing wrong in installation or ...

Any bridging setup is not permanent across reboot. There are various distribution
dependant schemes in the startup scripts to setup bridging on boot.  In most cases,
it involves editing a configuration file or files. Can't give exact advice because
Debian, Redhat (Fedora Core), Suse (Novell) all do it differently.
