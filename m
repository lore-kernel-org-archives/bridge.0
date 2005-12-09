Date: Fri, 9 Dec 2005 09:09:50 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Unable to learn macs on bridge ports
Message-ID: <20051209090950.09075491@unknown-222.office.pdx.osdl.net>
In-Reply-To: <43992197.5010902@innomedia.soft.net>
References: <43992197.5010902@innomedia.soft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: kanhu <kanhu@innomedia.soft.net>
Cc: bridge@lists.osdl.org

On Fri, 09 Dec 2005 11:47:59 +0530
kanhu <kanhu@innomedia.soft.net> wrote:

> Hi list,
> 
> I am using bridge-utils with uClinux having kernel-2.4.19.
> All the commands with brctl is working fine except the showmacs.
> when i execute the command
> 
> />brctl showmacs test
> 
> bridge name     bridge id               STP enabled     interfaces
> 
> It does not show any learned mac, So the bride(test) is not functioning 
> properly for unicast packets.
> Bridging option is already enabled in kernel.
> 
> Any help to proceed is welcome
> 
> With Thanks & Regards
>              Kanhu


What architecture? and are perhaps bridge-utils thought it had sysfs
support in the build, but it 2.4.19 doesn't have that.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
