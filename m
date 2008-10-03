Message-ID: <2e59e6970810031030p77a06914p81cea8ab994f59ac@mail.gmail.com>
Date: Fri, 3 Oct 2008 17:30:00 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <601216.59431.qm@web8804.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <601216.59431.qm@web8804.mail.in.yahoo.com>
Subject: Re: [Bridge] Problam with vlan interface of ath0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
Cc: bridge@lists.linux-foundation.org

On Fri, Oct 3, 2008 at 1:31 PM, rahul bhardwaj
<rahul_bhardwaj36in@yahoo.co.in> wrote:
> Hi to all,
>
> I have on setup where I have created one Vlan interface of an wireless
> interface ath0 (vconfig add ath0 100). By doing this I am getting one vlan
> interface as ath0.100. I already have one more Ethernet vlan interface as
> eth0.100. I have added both ath0.100 as well eth0.100 into a bridge. Now I
> am receiving DHCP discover packets on ath0 but then some how ath0 is not
> giving this packet to its own vlan interface ath0.100. That is why it is not
> reaching to eth0.100.

Do the incoming packets carry a VLAN tag (802.1q I think)?

>
> Can somebody explain this behavior to me. Why ath0 is not giving packet to
> ath0.100.
> Any kind of help be very much appreciated.
>
> Thanks a lot,
>
> With Regards
>
> Rahul Bhardwaj
>
>
> ________________________________
> Add more friends to your messenger and enjoy! Invite them now.
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
