Message-ID: <2e59e6970901121200s69fd6e6fr755224d8c004a67c@mail.gmail.com>
Date: Mon, 12 Jan 2009 14:00:31 -0600
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <EFD19D326CC92D43B5DDDE7431FBD8414C24F9DAC3@MAILCCR1.CRESTRON.CRESTRON.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <EFD19D326CC92D43B5DDDE7431FBD8414C24F9DAC3@MAILCCR1.CRESTRON.CRESTRON.COM>
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

If you want your patch to be understandable, create it as a contextual
diff with the -u option.

Do the pack pragmas really need to be conditional?  Pretty much every
compiler will do the right thing on encountering those.  (Using
__attribute__ as well, for compilers that support it, isn't a bad
thing but no need to avoid #pragma pack on gcc).

On Mon, Jan 12, 2009 at 1:22 PM, Manish Talreja <mtalreja@crestron.com> wrote:
> We have been using the RSTP implementation posted at this location:
>
> https://lists.linux-foundation.org/pipermail/bridge/2008-May/005859.html
>
>
>
> We have modified rstp.c and rstp.h to work with compilers other than gcc.
> Attached are two patch files that show our changes. Currently, we have
> tested this code with the Diab compiler (v 4.4a) and with IAR compiler (v
> 5.11).
>
>
>
> Manish
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
