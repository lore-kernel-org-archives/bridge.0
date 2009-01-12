Date: Mon, 12 Jan 2009 13:32:02 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090112133202.24eb9a08@extreme>
In-Reply-To: <EFD19D326CC92D43B5DDDE7431FBD8414C24F9DB8D@MAILCCR1.CRESTRON.CRESTRON.COM>
References: <EFD19D326CC92D43B5DDDE7431FBD8414C24F9DAC3@MAILCCR1.CRESTRON.CRESTRON.COM>
	<2e59e6970901121200s69fd6e6fr755224d8c004a67c@mail.gmail.com>
	<EFD19D326CC92D43B5DDDE7431FBD8414C24F9DB8D@MAILCCR1.CRESTRON.CRESTRON.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Update to RSTP lib
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Manish Talreja <mtalreja@crestron.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Mon, 12 Jan 2009 15:42:11 -0500
Manish Talreja <mtalreja@crestron.com> wrote:

> Here are the unified diff files as requested.
> 
> You are right about #pragma pack(). That's supported on pretty much all compilers. However, __attribute__ is not supported on all compilers and that's what was used in the original code. Our goal was to leave the gcc syntax the way it was in the original code. If you are ok with getting rid of the __attribute__((packed)), the code will be a lot more readable.
> 
> -Manish
> 
> 
> -----Original Message-----
> From: richardvoigt@gmail.com [mailto:richardvoigt@gmail.com]
> Sent: Monday, January 12, 2009 3:01 PM
> To: Manish Talreja
> Cc: bridge@lists.linux-foundation.org
> Subject: Re: [Bridge] Update to RSTP lib
> 
> If you want your patch to be understandable, create it as a contextual
> diff with the -u option.
> 
> Do the pack pragmas really need to be conditional?  Pretty much every
> compiler will do the right thing on encountering those.  (Using
> __attribute__ as well, for compilers that support it, isn't a bad
> thing but no need to avoid #pragma pack on gcc).
> 
> On Mon, Jan 12, 2009 at 1:22 PM, Manish Talreja <mtalreja@crestron.com> wrote:
> > We have been using the RSTP implementation posted at this location:
> >
> > https://lists.linux-foundation.org/pipermail/bridge/2008-May/005859.html
> >
> >
> >
> > We have modified rstp.c and rstp.h to work with compilers other than gcc.
> > Attached are two patch files that show our changes. Currently, we have
> > tested this code with the Diab compiler (v 4.4a) and with IAR compiler (v
> > 5.11).
> >

I would rather the code be cleaned out of the ugly macro's ifdef's.
Also only use pack if necessary (ie unaligned struct like:
      struct {
           char a;
	   unsigned b;
       };
If all fields are correct types to be naturally packed, then pack
is unnecessary. Compiler's aren't smart enough to recognize this
and assume misalignment so they will generate bloated code for anything
with #pragma pack

