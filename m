Message-ID: <fed120860811081044k52dbd99fs174d10cd2df33d34@mail.gmail.com>
Date: Sun, 9 Nov 2008 00:14:21 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY119-W404011B5F297F6E9D47DAA8B180@phx.gbl>
Subject: Re: [Bridge] Modifying All Packets passing through the bridge!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fahim Akhter <akhter.fahim@hotmail.com>
Cc: bridge@lists.linux-foundation.org

You could probably use the solution that was given to an earlier
question on this list (Bridge with a tweak...). The message is
archived at https://lists.linux-foundation.org/pipermail/bridge/2008-October/006074.html
.

On Sat, Nov 8, 2008 at 4:50 PM, Fahim Akhter <akhter.fahim@hotmail.com> wrote:
> Hi Everyone,
>
> I am currently working on a Ethernet Link Encryptor (so its called). The
> concept is to have two Subnetworks connected together using two bridges and
> the middle lays the internet connection or another network. The bridge is
> meant for encryption. The ecryption module and ready and working (
> independantly ) , if one bridge is set to crypto the other is supposed to
> turn on automatically.
>
> In crypto mode you only accept packet modified by the other bridge the rest
> of the packets ( rest of the LANS/INTERNET) are supposed to be dropped. In
> order to acheive that , I have to modify all the packets passing through the
> bridge so the other bridge is able to recognise it.
>
> I was modifying the packets in net/bridge/br_forward.c should_deliver() but
> on the other end I only received ARP packets as modified. Than I switched
> over to net/bridge/br_input.c br_handle_frame() but encountring the same
> problem. And in the kernel log only a few packets appear. ( dmesg , I'm
> printing a message )
>
> I need to Modify all packets passing through the bridge ( in kernel ) . Any
> Ideas ?
>
> Thanks,
> Fahim Akhter
>
> ________________________________
> Discover the new Windows Vista Learn more!
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
