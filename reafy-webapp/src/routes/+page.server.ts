import type { User } from "app/types/user";

let user: User;

export function load() {
    return { user };
}