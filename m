Message-ID: <2e59e6970810141607t64af8da0u76f9b1ec72fe4f15@mail.gmail.com>
Date: Tue, 14 Oct 2008 23:07:58 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <slrngf9qmd.866.ahuxley@dione.no-ip.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <slrngf7br4.5fa.ahuxley@dione.no-ip.org>
	<fed120860810131543w7a0ae9f7wf565d8dc10b06447@mail.gmail.com>
	<slrngf9o11.5jp.ahuxley@dione.no-ip.org>
	<2e59e6970810141144n3f48d792xb02db87916312a6@mail.gmail.com>
	<slrngf9qmd.866.ahuxley@dione.no-ip.org>
Subject: Re: [Bridge] pinging other side (normal bridge ok,
	anonymous bridge not ok)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexis Huxley <ahuxley@gmx.net>
Cc: bridge@osdl.org

On Tue, Oct 14, 2008 at 6:54 PM, Alexis Huxley <ahuxley@gmx.net> wrote:
>> You
>> already have trouble believing an ethernet switch can have an IP
>> address
>
> No; that that is possible was already clear to me.

I probably worded that poorly.  I guess I should have said "you prefer
not to think of the ethernet switch having an IP address", at least
that's the way I understand your explanation for not wanting to use
the working and perfectly good configuration where the IP address is
configured on interface br0 (which is I believe what 99% of other
linux bridge users do).

>
>> Because dummy0 is now a port of the ethernet switch, not a device
>> attached to the ethernet switch as you persist in claiming.
>
> Aaaaahhh! Yes, you are right, that that was exactly what I thought
> 'addif' was doing. Many thanks for the clarification!

Did you get a working configuration using veth as a virtual CAT5
cable?  Or did you decide to use an address on br0 after all?

>
> Alexis
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
