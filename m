From: Nick Fedchik <nick@fedchik.org.ua>
Reply-To: nick@fedchik.org.ua
Subject: Re: [Bridge] How to apply the patch ebtables-brnf-2_vs_2.4.21.diff.gz
Date: Fri, 1 Aug 2003 17:29:50 +0400
References: <3F2A28A8.A83C6AFC@hf.tu-darmstadt.de> <200308011013.26839.gdh@acentral.co.uk> <3F2A49FA.24278EE0@hf.tu-darmstadt.de>
In-Reply-To: <3F2A49FA.24278EE0@hf.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308011729.50436.nick@fedchik.org.ua>
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Cezary Sydlo <c_sydlo@hf.tu-darmstadt.de>
Cc: bridge@osdl.org

On Friday 01 August 2003 15:07, Cezary Sydlo wrote:
> Hi,
>
> tried it ... patch works fine but "make xconfig" does not anymore :-(
It's know bug. (was described in the ebtables-user@ maillist)

Here is the correct piece of net/ipv4/netfilter/Config.in
...
if [ "$CONFIG_BRIDGE" != "n" ]; then
    dep_tristate '  Physdev match support' CONFIG_IP_NF_MATCH_PHYSDEV 
$CONFIG_IP_NF_IPTABLES
  fi
...
Just add $CONFIG_IP_NF_IPTABLES at the end of line 47.


-- 
Best regards, Nick Fedchik
http://www.fedchik.org.ua

