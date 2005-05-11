Date: Wed, 11 May 2005 09:20:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Port link status disconnect
Message-ID: <20050511092035.465564b6@dxpl.pdx.osdl.net>
In-Reply-To: <6.1.2.0.2.20050511093531.05546510@luna.tlmat.unican.es>
References: <427D8B20.7010301@SiuLung.com>
	<6.1.2.0.2.20050509184627.05a787d0  @luna.tlmat.unican.es>
	<20050509105035.5f1c945f@dxpl.pdx.osdl.net>
	<6.1.2.0.2 .20050510115447.043b4c90@luna.tlmat.unican.es>
	<20050510145248.6041a7c8@dxpl.pdx.osdl.net>
	<6.1.2.0.2.20050511093531.05546510@luna.tlmat.unican.es>
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
To: Jorge Lanza <jlanza@tlmat.unican.es>
Cc: bridge@lists.osdl.org

On Wed, 11 May 2005 09:36:03 +0200
Jorge Lanza <jlanza@tlmat.unican.es> wrote:

> At 23:52 10/05/2005, Stephen Hemminger wrote:
>  >What distribution of linux are you using? Redhat, Fedora, Debian, Suse?
> 
> I'm using Fedora Core 3

Then you need to go into:
	Applications -> System Tools -> Network Device Control
	Configure
	Select device then hit 	Edit
	
	Uncheck the box "Activate this device when computer starts"

or edit /etc/sysconfig/network-scripts/ifcfg-eth0 (assuming it is eth0)
	and change ONBOOT=yes to ONBOOT=no

	
