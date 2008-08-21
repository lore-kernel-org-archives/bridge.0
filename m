Message-ID: <2e59e6970808210623r2cbf4801j5474f73e5dbc4dce@mail.gmail.com>
Date: Thu, 21 Aug 2008 13:23:03 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <442a305e0808182232r4591c018v1b33b3100d725ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <442a305e0808182232r4591c018v1b33b3100d725ac@mail.gmail.com>
Subject: Re: [Bridge] linux bridging problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: joy c <cjjoy1980@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Tue, Aug 19, 2008 at 5:32 AM, joy c <cjjoy1980@gmail.com> wrote:
> Hi,
>   I am trying to creat a bridge with the following command:
>         brctl addbr br0
>         brctl addif br0 eth0
>         brctl addif br0 pci0
>         ifconfig eth0 up
>         ifconfig pci0 up
>         ifconfig br0 up
>         dhclient br0
>
> I am able to see the bridge and interfaces to the bridge using brctl show
> command.. But when I run the
> dhclient br0 command, the system stops responding.  I am not able to see
> anything on the termnial and the termnial does not respond...  Please let me
> what is the problem....

Do virtual terminals still work (Alt+F2, Alt+F3, ...)?  If yes, then
you're not receiving a dhcp response and your dhclient is configured
with a long timeout.

If no, then one of your kernel modules is hanging your system.
Include the output of "uname -a" and "lsmod".

>
> Thanks,
> joy
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
